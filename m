Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A365875122D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 23:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjGLVFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 17:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjGLVFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 17:05:46 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70641FD2;
        Wed, 12 Jul 2023 14:05:44 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b9c5e07c1bso156095ad.2;
        Wed, 12 Jul 2023 14:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689195944; x=1691787944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d5kkWYvzz+2t+FZKT4iCqADaFhYm6kSyMz87+GrpApw=;
        b=Z1LY0yljwcmsuh8grez/YMZ8f+IQCgJAZT+VIUSwhi2aVznkMv6OJGrdD1aUst3sjJ
         PB9OrkAKfaZqRC4L7bjUgU3Dy49KDGlHvD0hZDiTVgdHW07Lpy9fxqZJa7nCvOgjNRtN
         W1JCJxB0CJoyCd0ZfB9weOs8ggU2DQYdt5FoVNz1nBniOc1w8/PSHkZcIpMJHzJm5qo4
         2xI8/tBTI3zOPMQV94n80RcFVVmQZu9J3fJqmxkOmKjE7PFWxLE3ACaT3Fs+nF7ID+e6
         amkb2OeLG9EzbnFRt/5Wsxhe7ggnuirhLeSo1hiq12fAsSMbC3mmtDjlC6x84pDs5U5s
         x5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689195944; x=1691787944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5kkWYvzz+2t+FZKT4iCqADaFhYm6kSyMz87+GrpApw=;
        b=b+GT9iCqmTae0svVEv9FaOxlBqCO8O2WASk50WTnKeEEJSEMng1nQ2FgPhTL7daPhs
         k6Lbr+E5XXwtrSqcshQGWiN06xQ5WMmWO31VQ6hsQAn4i9Qc6EE7b+dB6cFhoZjGB+Oj
         UQIVdE+01PqMtMTVazUxIS830kOV3b3LYtFqkYE44xfrxZFtu8QZFlngXEwbNmEpugJB
         AkPyE061QWMWAQthnmSRe909bkkSoa+gcwYJZjJj6rsjvQDhxfvMGQmsrk3FAHpaZ4do
         +Kpe6VR5CKuBcEwkZvODJoVUNaY6vJj2YV1p5l1weaVJCqKbH/zRjUiAuair7YZ0QUZM
         wPxQ==
X-Gm-Message-State: ABy/qLaeg9f/+eVx+FCLdgdt6yMPQM+/lHvmcTM5k5wXanK9+SI45G4L
        f4I7/+lJjWkYLXLEMtay6LC6EVkvHUU=
X-Google-Smtp-Source: APBJJlFfanj7Tcc69i1qMsC8WAU4C/RbjyrlgXWogVj1RcbikEcT9y0HtQSdFTSrHmHRwemIOkuPpg==
X-Received: by 2002:a17:902:d4ce:b0:1b8:7e53:70f with SMTP id o14-20020a170902d4ce00b001b87e53070fmr25384065plg.27.1689195944099;
        Wed, 12 Jul 2023 14:05:44 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:a606:1b1e:7f66:3ee0])
        by smtp.gmail.com with ESMTPSA id x18-20020a170902ea9200b001b9cb27e07dsm4408648plb.45.2023.07.12.14.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 14:05:43 -0700 (PDT)
Date:   Wed, 12 Jul 2023 14:05:40 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Werner Sembach <wse@tuxedocomputers.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: i8042 - add quirk for TUXEDO Gemini 17 Gen1/Clevo
 PD70PN
Message-ID: <ZK8VpEcPH8d3iZCJ@google.com>
References: <20230607173331.851192-1-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607173331.851192-1-wse@tuxedocomputers.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 07:33:31PM +0200, Werner Sembach wrote:
> The touchpad of this device is both connected via PS/2 and i2c. This causes
> strange behavior when both driver fight for control. The easy fix is to
> prevent the PS/2 driver from accessing the mouse port as the full feature
> set of the touchpad is only supported in the i2c interface anyway.
> 
> The strange behavior in this case is, that when an external screen is
> connected and the notebook is closed, the pointer on the external screen is
> moving to the lower right corner. When the notebook is opened again, this
> movement stops, but the touchpad clicks are unresponsive afterwards until
> reboot.
> 
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: stable@vger.kernel.org

Applied, thank you.

-- 
Dmitry
