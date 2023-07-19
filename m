Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380C77599E8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjGSPhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjGSPg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:36:59 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C2BE75
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:36:55 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-666edfc50deso683164b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689781014; x=1690385814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K38BxEYH26DFGpPyiTmHTMf3gy9MqzicLBbnOKCteTM=;
        b=M31KYUXdWst2TaY1F5jpsUdD4iaP74nNegJ7paY/HMXCBJrbgEohOPoyPhg0NjvTTF
         ZL1bbUaG1BYU4RWYHW3ZzhJaBZRzzB3zcSFsrJUy4zMYMZLN4ilfrMUMcXmvSRnx/t9f
         7LfMVIkncXDARpJfnBf5+vmvQgYgDJrih18Xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689781014; x=1690385814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K38BxEYH26DFGpPyiTmHTMf3gy9MqzicLBbnOKCteTM=;
        b=iSAEBsq/AgpNFwcSdcwMSejCkyzgr8KEO8b0/V2sOYQGqNZ+MCAlVAO7/ZxDEuHFgp
         rKbwWj/PLMeIcqCHrAQxff8LY6J0aBKu6/tURDWG1yJmVOaO+KdqgXVK1XNODxO5Ljsn
         MN8dVh13Ivu6IneuWO3FhNCRDDTGpV/sfK9ApRPtg7Ts8bSr6y2DILXkt3WCA/9BcCz5
         CuzsfMzDkEyTsEerCgfIegjgpDuHYdX3Wq3d2ZGVK/TaeYz5a30UcXKxsp0EpK2ZNwtT
         M39dmfJ0jLRjuOkQvnuws2V8+RSdk4MZ50aQ4ap5xuoD4gtN2eedjuL7j1sBOT5Q0fKN
         LtXQ==
X-Gm-Message-State: ABy/qLbhfaUalQkDR5r9Q0JGJn26/BEUZXE0nSuYC710/L9iefz7FTXS
        PfblzmSNosYDHY0l8g5S2saayQ==
X-Google-Smtp-Source: APBJJlH8qqAz5d6W7EDAD66e1X4MvOuGTuqq1LdVO/pyvNFME1BCH5jDHUK+QmS1hD0xqeuMV5+gjQ==
X-Received: by 2002:a05:6a00:cc2:b0:678:11d6:2ad6 with SMTP id b2-20020a056a000cc200b0067811d62ad6mr4173575pfv.9.1689781014193;
        Wed, 19 Jul 2023 08:36:54 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x3-20020a056a00270300b0065a1b05193asm3415022pfv.185.2023.07.19.08.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 08:36:53 -0700 (PDT)
Date:   Wed, 19 Jul 2023 08:36:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: Crash in VirtualBox virtual machines running kernel 6.5
Message-ID: <202307190835.752D710D@keescook>
References: <ab3a70e9-60ed-0f13-e3d4-8866eaccc8c1@lwfinger.net>
 <202307190823.086EFD42D9@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202307190823.086EFD42D9@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, please try:

diff --git a/fs/vboxsf/shfl_hostintf.h b/fs/vboxsf/shfl_hostintf.h
index aca829062c12..902fe3224453 100644
--- a/fs/vboxsf/shfl_hostintf.h
+++ b/fs/vboxsf/shfl_hostintf.h
@@ -68,12 +68,11 @@ struct shfl_string {
 
 	/** UTF-8 or UTF-16 string. Nul terminated. */
 	union {
-		u8 utf8[2];
-		u16 utf16[1];
-		u16 ucs2[1]; /* misnomer, use utf16. */
+		DECLARE_FLEX_ARRAY(u8, utf8);
+		DECLARE_FLEX_ARRAY(u16, utf16);
 	} string;
 };
-VMMDEV_ASSERT_SIZE(shfl_string, 6);
+VMMDEV_ASSERT_SIZE(shfl_string, 4);
 
 /* The size of shfl_string w/o the string part. */
 #define SHFLSTRING_HEADER_SIZE  4


The size assert doesn't seem to be used anywhere else, but I can do a
more careful binary analysis later today...

-- 
Kees Cook
