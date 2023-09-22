Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1497AB976
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbjIVSnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbjIVSnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:43:04 -0400
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576D5A9;
        Fri, 22 Sep 2023 11:42:58 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1bd9b4f8e0eso22204175ad.1;
        Fri, 22 Sep 2023 11:42:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695408178; x=1696012978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xyo5smHq1lcBrq86jPuYK6bRn55xTRRhvulYa+HVpfs=;
        b=mu1LYgBbLF6JvDQ+ABMeylsdOKjFs61wks4E8TH/3WAZQRInMJfj+WcXaUkRDzIwHd
         QWSKERxMelZKJjqCAi9/qi0zn/Q/bLsjSCG8vQ1TGCBO0mpoJJcIKgXA9qDFcWqgKrFv
         e7kKrL5L8pl5as4JWl5t+WbwvaWQsCDUSC3wNQWbsRmTKBhkK5QnuWxmytLWmCAlQz1e
         c5UlsRFqDkeMcOnqSsm+b9AkS6pWrVxzPDUQhthEfjUc8ywfaCzzavltV0mTkjLwvfNl
         5A91yvfyiAsI1nNGHVNhY38TcDnpI5pAZOkqpOounNQGOXzMjUAOkz1skihwcXFnslyi
         z2eg==
X-Gm-Message-State: AOJu0Yxdphzl5WG3r3Ex8rmd1nHJ7xfZXribQwL5zcn15LffD7276KZC
        qw6wbqu8TQRZLFj7PlL5IKY=
X-Google-Smtp-Source: AGHT+IHNNUmZXq4I7Ud3HtpxtRX25D2fErKcbqMeUoQZ3ThvtRfaXD0MP2suZTAqagTNivW3lLZZ0w==
X-Received: by 2002:a17:903:22c9:b0:1c5:b4a1:ff6 with SMTP id y9-20020a17090322c900b001c5b4a10ff6mr357180plg.45.1695408177720;
        Fri, 22 Sep 2023 11:42:57 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id ja2-20020a170902efc200b001c0c79b386esm3846381plb.95.2023.09.22.11.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 11:42:57 -0700 (PDT)
Date:   Fri, 22 Sep 2023 18:42:14 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        minipli@grsecurity.net, ssengar@microsoft.com
Subject: Re: [PATCH v2] x86/hyperv: Remove hv_vtl_early_init initcall
Message-ID: <ZQ3gBk8fbHLo7Gl6@liuwe-devbox-debian-v2>
References: <1695358720-27681-1-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1695358720-27681-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 09:58:40PM -0700, Saurabh Sengar wrote:
> There has been cases reported where HYPERV_VTL_MODE is enabled by mistake,
> on a non Hyper-V platforms. This causes the hv_vtl_early_init function to
> be called in an non Hyper-V/VTL platforms which results the memory
> corruption.
> 
> Remove the early_initcall for hv_vtl_early_init and call it at the end of
> hyperv_init to make sure it is never called in a non Hyper-V platform by
> mistake.
> 
> Reported-by: Mathias Krause <minipli@grsecurity.net>
> Closes: https://lore.kernel.org/lkml/40467722-f4ab-19a5-4989-308225b1f9f0@grsecurity.net/
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Acked-by: Mathias Krause <minipli@grsecurity.net>

Applied to hyperv-fixes. Thanks.
