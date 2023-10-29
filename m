Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C247DAC9C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 14:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjJ2NbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 09:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjJ2NbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 09:31:04 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6596FC1;
        Sun, 29 Oct 2023 06:31:01 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32d849cc152so2481550f8f.1;
        Sun, 29 Oct 2023 06:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698586260; x=1699191060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wjTKSpgCXBTZNFEF34LbUkgx3lFoLre8XTN0Wc+jn58=;
        b=Or2ZE7gccARb6cHHeH+0WFEY0+ihrxAAsF58bOBzf3blPoNhwfEmRsAbYPNT76vECM
         sUaPRpxcqmFpvkmPTL1dgkWnRa2l6efJF/r45D9fw1IyviPeeZS+9KYtHOP1Df/af7+u
         N/tEIlEuVnz2mD/B2uoJ5T/4KzRcfap6etK7LdarAf3t1CPZntErSrZNydUW6XABMTyD
         Wy6zGdgJtBgoJkmGwLz566xQVgX4/jrSaubmKj7BR3SP5YPBQvNItJ2NAHP0JYAZ+Ji8
         +JWZn1d/YVCwt6klO0N9epYRZsd7Tr6aDjKLHF6tUUKcOolO3B+KdRN0LjlAgH2/+23t
         AFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698586260; x=1699191060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjTKSpgCXBTZNFEF34LbUkgx3lFoLre8XTN0Wc+jn58=;
        b=TqLaHCTqSvdjJHsldnWGOobeC/Qhh8meL6ESHMti1+kSEt7RjY5CW++HPwjQcBTM/d
         rQJ8oxYsLOtoZIwrfrjHfvYl3xiiS2EtQsO5sae+LsrjAE6/W7ZPzwOyOgv1z8DDPJyK
         y9j3wnpoiSExqafmgfk3pXk6KPVCp4IFsjhQRarc4X27OW1JvZjzGhhPF8lDVyFjxkkO
         N/z6XSkLzxmh1kplRzWRfM/H4T+ahZ1NfUQYHd87jTsAV+JeG1ZtzI0Mk1NV0vbXxEc3
         hm7h8zh9dcUTVTrmWfLK6bUUKkS+0Dl97Sz8Szwvr9OvF8WRlbeyPps3FtCptTRquRii
         zabg==
X-Gm-Message-State: AOJu0YxrOIrxMbEeXFWs9Kyf4NJMdJ16gnGRaIt52NrJ6N6ZhKf+FHnN
        iI9DdlbZzzujPBfmPSPcv9Q=
X-Google-Smtp-Source: AGHT+IGySgY0XkJrOiM9YZe+8s9d9RbG7lp8fMh480ncOn+eMKalG6RPMjs4RNn8PC1/c8iccPP44g==
X-Received: by 2002:a05:6000:156d:b0:32f:7db1:22fe with SMTP id 13-20020a056000156d00b0032f7db122femr3098819wrz.15.1698586259558;
        Sun, 29 Oct 2023 06:30:59 -0700 (PDT)
Received: from localhost ([2001:171b:c9bb:4130:c056:27ff:fec4:81cb])
        by smtp.gmail.com with ESMTPSA id d2-20020adff842000000b0032d9a1f2ec3sm5980969wrq.27.2023.10.29.06.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Oct 2023 06:30:59 -0700 (PDT)
Received: from localhost (localhost [local])
        by localhost (OpenSMTPD) with ESMTPA id a0d658f0;
        Sun, 29 Oct 2023 13:30:57 +0000 (UTC)
Date:   Sun, 29 Oct 2023 14:30:57 +0100
From:   David Lazar <dlazar@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>
Subject: Re: [PATCH] platform/x86: Add s2idle quirk for more Lenovo laptops
Message-ID: <ZT5ekV2JaWhf5bWF@localhost>
References: <ZTlsyOaFucF2pWrL@localhost>
 <e2370602-256a-4c30-b73f-1552d7d8bf22@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2370602-256a-4c30-b73f-1552d7d8bf22@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023, Hans de Goede wrote:
> I'll prep + send a fixes pull-req to Linus
> with just this single patch tomorrow.

The patch recently landed in Linus' tree, so thanks for that.

I didn't realize that the fixes for this laptop family would be also
considered for the stable trees, so I hadn't Cc-ed
stable@vger.kernel.org in my original patch.  But I now see that gregkh
picked up Thomas' fix for stable-6.1 and stable-6.5:

https://www.spinics.net/lists/stable-commits/msg321665.html

So, should we also forward this patch to gregkh, to make these laptops
work with the stable trees?  What's the process for that?

Thanks,
-=[david]=-
