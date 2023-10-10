Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD8D7BF16B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 05:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441999AbjJJD17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 23:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441980AbjJJD16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 23:27:58 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD3792
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 20:27:55 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c888b3a25aso31016815ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 20:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=transsion-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1696908475; x=1697513275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bhbfhOiDXMThusPUaqJIFZw5gF6ALBs624t1yiARxuI=;
        b=pSizT54Ohz8K8hgMvlbgyLdN1+rLlyUx/3L7HxAJiXheKX7GUh8EiCEMq/XP3hY4Lk
         8bKseyBqWHx/UIFculPIF86i+C0lkFfyE296glB+/wBhup6zCUHCKG+dXCuXoxhy1EQT
         kK9qOEFCq9J6c3Q6wm+n1B8H6Ql8efuEUxzyzFtMJpM9sBkT0eanS0wn0aTpiVlY4IFH
         vm+9pSYPm5rBczUsnLzcd0+Pko8PImbqmZAyRk7ScvZVXUubMtaxML6KzSNxSjnPV+4P
         LyfVCA3IVKHpSSfkU9Ji3eJpMD5aalcvQcuMa2X6Nb25WzjnAC2sHZNtBiSO/a+gkZmf
         kkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696908475; x=1697513275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhbfhOiDXMThusPUaqJIFZw5gF6ALBs624t1yiARxuI=;
        b=Hgi8NLgcwV1GpskteTQcZx7ISFvmXj5rnmmZRC4V2YXucSGlEWjLwDeRaEr5lIskco
         CN4EdrcBY8zgrC95u9MJ/9P5BTSewCfUqx/GRgWAM6SxXx7/cL6DqbUclKzzMevEMGQu
         WhsGQFFT8U/R02l/+jNgl1h6S2WuFICtks9v3rmy8ae4FagL3Z5XQgW8AKziVYdRgvq5
         8mfeeAthB34Z6uy5+hbkcOY3R/2LgAsiypgqGPr13ctIohTfGBw+4O70C04LU9KajtU4
         cLIdubZPkrFAQMJsZR/wONu1YuuFsZYYmQZA5TxHEnbSDQxf3RluCisrTC7Jl3mH8yqs
         qF0A==
X-Gm-Message-State: AOJu0YyWFG3Hn27Vs7lcTxFEQdrqK5ZR3JVZTcXJVF233J5otTiTHtdQ
        GQkkB4A2Bkx9gsQkhOv3crKn1w==
X-Google-Smtp-Source: AGHT+IFd8YeEDe6d/8Tnj7xI+kI9zS2Soyi/j4sYAX77sIX22IGPuRL4SC918/Kv9bQnvhrt0rY1ow==
X-Received: by 2002:a17:902:744b:b0:1c9:b19f:7edb with SMTP id e11-20020a170902744b00b001c9b19f7edbmr700199plt.52.1696908475192;
        Mon, 09 Oct 2023 20:27:55 -0700 (PDT)
Received: from linchengyang-VB ([103.40.76.4])
        by smtp.gmail.com with ESMTPSA id y13-20020a170902ed4d00b001c898328289sm6718526plb.158.2023.10.09.20.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 20:27:54 -0700 (PDT)
Date:   Tue, 10 Oct 2023 11:27:46 +0800
From:   Lincheng Yang <lincheng.yang@transsion.corp-partner.google.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, rostedt@goodmis.org,
        mhiramat@kernel.org, hughd@google.com, peterx@redhat.com,
        mike.kravetz@oracle.com, jgg@ziepe.ca, surenb@google.com,
        steven.price@arm.com, pasha.tatashin@soleen.com,
        kirill.shutemov@linux.intel.com, yuanchu@google.com,
        david@redhat.com, mathieu.desnoyers@efficios.com,
        dhowells@redhat.com, shakeelb@google.com, pcc@google.com,
        tytso@mit.edu, 42.hyeyoo@gmail.com, vbabka@suse.cz,
        catalin.marinas@arm.com, lrh2000@pku.edu.cn, ying.huang@intel.com,
        mhocko@suse.com, vishal.moola@gmail.com, yosryahmed@google.com,
        findns94@gmail.com, neilb@suse.de, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, wanbin.wang@transsion.com,
        chunlei.zhuang@transsion.com, jinsheng.zhao@transsion.com,
        jiajun.ling@transsion.com, dongyun.liu@transsion.com,
        Lincheng Yang <lincheng.yang@transsion.com>
Subject: Re: [RFC PATCH 4/5] mm: add page implyreclaim flag
Message-ID: <ZSTEssvguIBz5XWB@linchengyang-VB>
References: <20231008095924.1165106-1-lincheng.yang@transsion.com>
 <20231008095924.1165106-5-lincheng.yang@transsion.com>
 <ZSKNhZldD8P3l7hA@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSKNhZldD8P3l7hA@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2023 at 12:07:49PM +0100, Matthew Wilcox wrote:
> On Sun, Oct 08, 2023 at 05:59:23PM +0800, Lincheng Yang wrote:
> > Add implyrecalim flag means that the page is reclaim from the user advise.
> > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > index a2c83c0100aa..4a1278851d4b 100644
> > --- a/include/linux/page-flags.h
> > +++ b/include/linux/page-flags.h
> > @@ -138,6 +138,7 @@ enum pageflags {
> >  #endif
> >  	PG_hot,
> >  	PG_cold,
> > +	PG_implyreclaim,
> >  	__NR_PAGEFLAGS,
>
> Can you do all of this without adding three page flags?  We're really
> tight on page flags.  At a minimum, this is going to have to go behind
> an ifdef that depends on 64BIT, but it'd be better if we can derive
> hot/cold/implyreclaim from existing page flags.  Look at the antics

Sounds good, we will try to do it with the exist page flags, if the exist page
flags does not achieve our goal, we will use an ifdef that depends on 64BIT.

> we go through for PG_young and PG_idle; if we had two page flags free,
> we'd spend them on removing the special cases there.
>
