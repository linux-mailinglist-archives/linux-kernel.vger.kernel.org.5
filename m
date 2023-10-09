Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD9F7BD5FC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345610AbjJIJAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345584AbjJIJAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:00:11 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1A6A3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 02:00:08 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99c1c66876aso774880766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 02:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696842007; x=1697446807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=16Pp5mIXsXhcKY6/PNwMMISjDcrkfl3XOTTQoKRx0Sg=;
        b=YjuHPoOR+QrShHWwABZQDZOM6nIurk1s676xl33hh9UkBPZdJG+MpxYmif5Kjpb9WY
         zs8lWb/0UC7iLqgETgmLZ+AuEBWwMm3VkRUqEl2thSmh5h+Nqzj4mRCnj32+sZHNiq/e
         ngr/4mPwT9XHexI8FC5SWzhl3ckICER+IGUNXhgdl6a1DOps4TI2J0HCgQ89m2J2dFZa
         uRqtyOdd+6eYAYyvvGMNBICuaZAhrkfpqXXYF8tdFw8Bryi7P21QKym1Z77ZDSPlAVqo
         0x67e2vdXwIg+o3BX/roRSfC+HgCK4RCr7fIbmJtcwsh5aW+AGHy7Qq0j/HJU5EcetIH
         BQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696842007; x=1697446807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16Pp5mIXsXhcKY6/PNwMMISjDcrkfl3XOTTQoKRx0Sg=;
        b=gydYeMMhF9Q8EXKTaDS8sRuUywVzEdagj+PEtLPpwppoBte8Tz3zPU1NkRixVd9gGA
         et+5MbXKss+bQwDUf2l6AlhQH2pRBEKyq06MjsxK5Xa+C34iBSeoBJtXn8hRvL/bWNPp
         iVcJaz/QQor6TCGINHN9GKNBFslX0IkQDs0JCXCglaXSp/RRVibpzWamIa022FoPuUVd
         OpsAVp7WvSlK1Zs3ArXGoaweXW6E4I3v6gD+5w47Ydxt7F2Ecyb3/4M2QUXtnlBXy/xX
         UtkDzV7RLw3vIID13f0sxe5xK0XbSmLTQuUrfJ5Zywp/j70Cg8dWGG5A4/BKlQ2UazjF
         7DBg==
X-Gm-Message-State: AOJu0YwBtQKAznf1/72L+TtZNp6KglOfx/Ix+sdpsErEdfc07IYpMnDc
        5LEcFA+ktFc0S/qXoq+y7Q==
X-Google-Smtp-Source: AGHT+IFZ2Vekv6DwvVXAs8HpHQDb6nMrYTbl+PtZBP4YBQXuGYf/JHzH0Llzp6k5rWKYnotnyC+0zw==
X-Received: by 2002:a17:906:8467:b0:9ae:62ec:f4a1 with SMTP id hx7-20020a170906846700b009ae62ecf4a1mr12591350ejc.33.1696842006933;
        Mon, 09 Oct 2023 02:00:06 -0700 (PDT)
Received: from p183 ([46.53.254.83])
        by smtp.gmail.com with ESMTPSA id p27-20020a17090635db00b009b654751c14sm6453778ejb.47.2023.10.09.02.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 02:00:06 -0700 (PDT)
Date:   Mon, 9 Oct 2023 12:00:04 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org, hughd@google.com,
        swarupkotikalapudi@gmail.com
Subject: Re: + selftests-proc-add-proc-pid-statm-output-validation.patch
 added to mm-nonmm-unstable branch
Message-ID: <f50cfce5-5e46-433f-be48-a8c733843457@p183>
References: <20231004201701.87CB5C433C7@smtp.kernel.org>
 <9ce82fc2-4e09-40c4-b5a5-a9a049c2f493@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9ce82fc2-4e09-40c4-b5a5-a9a049c2f493@p183>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 09:14:53AM +0300, Alexey Dobriyan wrote:
> On Wed, Oct 04, 2023 at 01:17:00PM -0700, Andrew Morton wrote:

> > +		if (errno == ENOENT) {
> > +			/*
> > +			 * /proc/${pid}/statm is under CONFIG_PROC_PAGE_MONITOR,
> > +			 * it doesn't necessarily exist.

Oh, and /proc/*/statm is _not_ under CONFIG_PROC_PAGE_MONITOR,
it always exists.
