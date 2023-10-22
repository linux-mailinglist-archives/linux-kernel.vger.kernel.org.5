Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253A77D22A7
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 12:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjJVKik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 06:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVKii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 06:38:38 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79360A7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 03:38:36 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6b26a3163acso1652399b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 03:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697971116; x=1698575916; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CRC3MPU3+PlhHX1INeJam66eUqKFQK25lowlCfDUuQY=;
        b=eRwDywCchBgX85XSiZDljN9TJ0TTUgcdWCQ95FsvSaG0uZxQUx6dTFXtfLCKw36TlO
         9votsthVEl9FtQoqtw6QyocIBxMkLdgASm+XEq5bHYlLaOro/RQA+LjpBLHrnpAbZQMN
         GkS5+csMxRY+x91cltgR69uiSOFYmt/HoGSgGRc/Jy6ntegW0JGHXFipcp98qq0czffu
         rS9MkedEQetoribSnNzWoIvZFaZKo+WiuqNFY5wAfBNtAroAtlnB/BgtQX90/t+4Yz8Z
         NBgpgz3d5M+t2O+6UHYmoC1WTc1h+QXZCa6xAVfTeYwj69vJAnZhnE1fVWL7Lr+kT4T0
         MuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697971116; x=1698575916;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CRC3MPU3+PlhHX1INeJam66eUqKFQK25lowlCfDUuQY=;
        b=GxHUms7HOpM8PFsMXih4czPL9csrqmIlpBhU2/dex7+Qq9cczqt5aLYlyE+Z49sEJv
         L0pFMOSRGRUl1DbyOfmTMotjpIhmB4AuS93UQrSQ+FdGrU/yXucufyrplxSAmAn+U61l
         zLwTevX4AU/OQ2SzHvQM1bOtkfNIaLzvKf7jGedEcKk2Q1mYhT8ALo1z8E0z0+vOFLcM
         y7Uh1Y3T4TktwAN1fuTU2F8AIH8gMkyR12dsp/rNWC7yhWVtV5F0dXoiVTor6M7+WFmO
         Upc8EY9Qva7gBvnZFVkiE45MthYxbCX8asEILNaXdXR7csAHmLHeKseXZ+7d8I7GmoEN
         kVzA==
X-Gm-Message-State: AOJu0YxCeksK2/vlM66DKazlRffUYVkgWOSlloCJfsMw/K9BFSg2d1st
        DeP/eOMK6VLJc/jrQci6K2TyLJAUUqI0aw==
X-Google-Smtp-Source: AGHT+IHLNW3llJuF9Jr1idWiYVPYxCXj7/J92O3j8sKW3d6kkonFkmwwSrHZIRNVYjH1Gjo9LhGN6g==
X-Received: by 2002:a17:90a:c20d:b0:27d:2e5b:55ca with SMTP id e13-20020a17090ac20d00b0027d2e5b55camr4158127pjt.26.1697971115820;
        Sun, 22 Oct 2023 03:38:35 -0700 (PDT)
Received: from ubuntu ([122.171.143.200])
        by smtp.gmail.com with ESMTPSA id 8-20020a17090a1a4800b002776288537fsm4538411pjl.53.2023.10.22.03.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 03:38:35 -0700 (PDT)
Date:   Sun, 22 Oct 2023 03:38:21 -0700
From:   Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
To:     Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     kumaran.4353@gmail.com
Subject: [PATCH 0/3] staging: greybus: Coding style cleanup patches
Message-ID: <cover.1697969950.git.nandhakumar.singaram@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset performs code cleanup in greybus driver as per
linux coding style and may be applied in any sequence.

Nandha Kumar Singaram (3):
  staging: greybus: Modify lines end with a '('
  staging: greybus: Alignment should match open parenthesis
  staging: greybus: fixed prefer using ftrace warning

 drivers/staging/greybus/bootrom.c |  2 --
 drivers/staging/greybus/camera.c  | 13 ++++++-------
 2 files changed, 6 insertions(+), 9 deletions(-)

-- 
2.25.1

