Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18339767879
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 00:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbjG1W1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 18:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbjG1W1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 18:27:41 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346D94497
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 15:27:25 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b8ad356fe4so16685155ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 15:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690583244; x=1691188044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TxEx9u7RuHaHHSAnVYLqhTOHTd/40wiauXx1aUUDndM=;
        b=Z+C4c8F3slTpu55XXPhcK91pA9ZANhBF0nQSY3VqLyL3GCx21bSh98cqoHvQlzHymC
         KfVryApQS0u7o0gzK/nWleHtVB5NdSP7Fgv4kG0uhXwCgPcr+vKP0ZnEW7rtIMRD8BIi
         SBXQqnkoi7RHK/SBJ4sGoL6hN9PwmYvy7rSVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690583244; x=1691188044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TxEx9u7RuHaHHSAnVYLqhTOHTd/40wiauXx1aUUDndM=;
        b=ClAjlxZLLw2QtUKmsrP4zI0nDNwoacdGg5F60iKEPtTM3uBymUiF0KDAlvMAYENo0i
         uwE4eVKQXxtIQyGcYkaaQmA/KYltwR0OfVm2CCVVReAubsRxUzolmgyUfyhyrtSIJWFL
         YdWLoOrh1B/vHAroB7dye034Hrezyic3i5M7RUgk/XSMc2tt45pWFZ7wZl7wXWCBcX61
         jNn/lVUNNf0aVphIfUN2CJtPQF4NuYj6+MKGdG2kTWMjbOvXtMLSYNc/qdfzsvZueFEW
         ufvxTOuJnLZA5AsZrEOixhK5qYp3cCoxul+I96ry7aMX3cc4WA/jffEzx36nOoC081gB
         JuqQ==
X-Gm-Message-State: ABy/qLYld0m0nOmUiTpfWIIEBQCXGZ1Gw0kO0qNr434ZlyGP+WlWhaqK
        2pUxl0t5TZg2zaw5SLu/5S5WQA==
X-Google-Smtp-Source: APBJJlHBVzfsxrvTTcHtfT0hMHfSLGFwmQxpbcF29cfghuRDdTwZqlUmv4wbk5g/l4EOtyHqWniFPQ==
X-Received: by 2002:a17:902:e885:b0:1b8:8262:7333 with SMTP id w5-20020a170902e88500b001b882627333mr2738551plg.51.1690583244595;
        Fri, 28 Jul 2023 15:27:24 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a18-20020a170902ecd200b001b7fd27144dsm4100996plh.40.2023.07.28.15.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 15:27:24 -0700 (PDT)
Date:   Fri, 28 Jul 2023 15:27:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     James Seo <james@equiv.tech>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] scsi: mpt3sas: Fix an outdated comment
Message-ID: <202307281527.290DBFE9C7@keescook>
References: <20230725161331.27481-1-james@equiv.tech>
 <20230725161331.27481-5-james@equiv.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725161331.27481-5-james@equiv.tech>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 09:13:29AM -0700, James Seo wrote:
> May reduce confusion for users of MPI2_CONFIG_PAGE_IO_UNIT_3::GPIOVal[].
> 
> Fixes: a1c4d7741323 ("scsi: mpt3sas: Replace unnecessary dynamic allocation with a static one")
> Signed-off-by: James Seo <james@equiv.tech>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
