Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25DA7D0BEC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376708AbjJTJeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376783AbjJTJdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:33:41 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97745D55
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:33:23 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5384975e34cso861672a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1697794402; x=1698399202; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/B2a2ZXqLwls1Vsw3h8JmPF3a45COfQmKittozQNWE4=;
        b=kvsXwxgbbBHLrKSqKTT2LlGy7jtyy9VqQKk4e9XS5oHt79uosPExgdSzyY+wSI8Wcp
         gd+GRl9EADqF5z47SjLWcXBBM7N+AdB5z0JZy8fLzkTOXDo6ZLdWvLi2p09deVy0qWr5
         lQidFsZzjsRJHGy7fnR7xYFOFLlMFhe+iCo6jZzx8tZHcryIKZ9M7YXmlrztqetyr6Tc
         U2BrSwV+yby/sxVS1JKklGCgYJtHVGchhlwWxIG6aj0Qzuz3CSvAtPubKF9ZOgvOKb7+
         WmZbFyFhQXSuOcUWIq1GiR+IdFiMLvHNfMqSSvinAEIL3iySOEtvllMj0hK1vjM5AGOH
         EUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697794402; x=1698399202;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/B2a2ZXqLwls1Vsw3h8JmPF3a45COfQmKittozQNWE4=;
        b=M6iMY0V8hTENfAUALlN7KdtsXPStNKuTSaR2L3ZI7ooS4TG9FbLJRtVfkgIKtuuNi9
         X8QwJcZ9snZKdBMXvpJiiqAB8n2gmI5gn9BdT/j0cDN/h0e3d6rlbYHxGVtLy9mRFTOk
         Xy1+QLfQ0xzjucG9G/QU0+rz/wXZDR+OJMnT69TCffzDvrXBxwieLor46Y8ehSRu4eqG
         dJHisjPcYlAgtSFyHeeUcIYBvbRi5FfCHjSD++GMAZXZIyHOO+AsAnPO9kur5hdJdAjS
         2PeqKYFx8TCrCASvU6KRjt72fCHsi1z6NIm/CCnCdsOEjbAdD+E4XTkKeqt0Z0dGgDLm
         oBuQ==
X-Gm-Message-State: AOJu0YxRhCd5DuBQaVV84KSBnMXVkAAsh9gQOmLmAVxxR6TCak26ClDN
        4VQlDK0G8LQ4x/LlnddvfcwD5Q==
X-Google-Smtp-Source: AGHT+IFVzakVPdt1/cwktBRmr1g7l+TM3g6ka7ob34Ou2CK7EFqYB723oYUCwfieN9a13Q1zXeTLhA==
X-Received: by 2002:a17:907:7ea3:b0:9c6:10d4:d09f with SMTP id qb35-20020a1709077ea300b009c610d4d09fmr993488ejc.63.1697794401731;
        Fri, 20 Oct 2023 02:33:21 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (k10064.upc-k.chello.nl. [62.108.10.64])
        by smtp.gmail.com with ESMTPSA id t15-20020a1709066bcf00b009a13fdc139fsm1102535ejs.183.2023.10.20.02.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 02:33:21 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v2 0/3] Handle reversed SBU orientation for FSA4480
Date:   Fri, 20 Oct 2023 11:33:17 +0200
Message-Id: <20231020-fsa4480-swap-v2-0-9a7f9bb59873@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF1JMmUC/3XMSw7CIBSF4a00dyyGV6B15D5MB5SC3IHQgEFNw
 97Fzh3+JznfDsVldAUuww7ZVSyYYg9+GsAGE++O4NobOOWCUSaIL0bKkZLyMhuZFuq1WrWwbIJ
 +2bLz+D6429w7YHmm/Dn0yn7rH6gyQskyau0Vp1JZe/UG8xZSdGebHjC31r4InkxlrAAAAA==
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Short reason:
Without swapping the SBU lanes, on QCM6490 Fairphone 5 the
DisplayPort-over-USB-C doesn't work.

The Orient-Chip OCP96011 used in this phone is generally compatible with
FSA4480 but has a difference how AUX+/- should be connected to SBU1/2.

Long explanation, with my current understanding:
* FSA4480 block diagram shows AUX+ connected to SBU2 and AUX- to SBU1.
* OCP96011 block diagram shows AUX+ connected to SBU1 and AUX- to SBU2
  (it's not 100% clear though in the picture but makes sense with the
  observed behavior)
* Fairphone 5 schematics have AUX+ connected to SBU2 and AUX- to SBU1,
  which would be correct for FSA4480 but since OCP96011 is used (which
  expects it to be the other way around) the Linux driver needs to
  reverse it.
  If AUX+ would be connected to SBU1 and AUX- to SBU2 as shown in the
  OCP96011 block diagram, then no driver/dts change would be needed.

Not sure if I've implemented the best solution in this patch. Other
solutions I could think of are:
* Add some custom boolean property to the node, e.g. 'fsa,swap-sbu'
* Reverse when ocs,ocp96011 compatible is used. This would be incorrect
  since when following the OCP96011 block diagram no reversing would be
  needed, as explained above.

However I think the current solution with data-lanes in the endpoint is
the best fit and is also already used for a similar purpose in another
USB mux driver.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v2:
- Expand commit message for first dt-bindings patch incl. ASCII art
- Use fwnode_* instead of_* APIs
- Drop manual check for data-lanes property length, read_u32_array will
  already error on too short or too long property.
- Drop dev_info for reversed data-lanes mapping
- Link to v1: https://lore.kernel.org/r/20231013-fsa4480-swap-v1-0-b877f62046cc@fairphone.com

---
Luca Weiss (3):
      dt-bindings: usb: fsa4480: Add data-lanes property to endpoint
      usb: typec: fsa4480: Add support to swap SBU orientation
      dt-bindings: usb: fsa4480: Add compatible for OCP96011

 .../devicetree/bindings/usb/fcs,fsa4480.yaml       | 43 ++++++++++++-
 drivers/usb/typec/mux/fsa4480.c                    | 71 ++++++++++++++++++++++
 2 files changed, 111 insertions(+), 3 deletions(-)
---
base-commit: e3b18f7200f45d66f7141136c25554ac1e82009b
change-id: 20231013-fsa4480-swap-9b0f76d73c19

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>

