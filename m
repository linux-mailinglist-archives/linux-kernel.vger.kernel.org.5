Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96177CEE85
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 05:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjJSD4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 23:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjJSD4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 23:56:36 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26B3119
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 20:56:34 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1ca79b731f1so8594855ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 20:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697687794; x=1698292594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MXhYXE2GnBHkpiX1l+JOQUTo2U8OPcDThZ0EqZcnynw=;
        b=ZAP6ZmjrLVDv/gNKQ/02B7O1G8G+Bd+0u2rfT+AkPliMi/pQs69+iyLrvllbqbNfBX
         LO+pI/GBBZS/CqhDrzlQnGYlYdYqYZl0pCdczNHf9H+nyZAKh8JLrpyHfcqH1UBGgROu
         jIo2VyADN1fA5xAbUiIoP2ANkjaaIF/BVHT20EGX046Rs52RhyNNprB+5dCxyfbGTroO
         iNgjAPjAbPESp1WzB0FTra39BdPJ/VStmesyYiKknuQGZ0C9aGIWuGvLZQPQjqgwTPYz
         bKoVkFH0AzvMzSqcQYBHpHuU7ebT43Pa1WNrmS6Ki0SH76oKIStR+CXy+JiqWEog4zH9
         JoPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697687794; x=1698292594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MXhYXE2GnBHkpiX1l+JOQUTo2U8OPcDThZ0EqZcnynw=;
        b=UBTXV9CAqNRyjqAzfsISeKI4FrEYrt4/sIbh2T1IAxDc1+oVIPy1+L4Y1WzONDp+ZA
         lLdVsIktj+9jKkzaptBnug43oyusnvNm4OB8SiC8qjDj8PkkpVk1CBz13EKtCjanKXbu
         IDG4yncMeUBgVlhwLslOvOaQ3jTsyidnkp8erh5WCXRAWTmS1SYfDVGA/8Y3SUhGlhC/
         VuJH7Se1ts/isqvu3HNlk26Ccp68OQp7x8cV1OunWvEsPyd23jJoDjMLOGCtNOk8XfEU
         90/BfhwMMU3MIPkygmCBkbFl/UT05rpTcPdCkZVClhIgUa75H1IWf4+j6v5qNkQHC+O4
         s5VQ==
X-Gm-Message-State: AOJu0YwZzCFPUiIKWwqwNVWYFRwF/PTkCXSMHDddp3s+3G1Up6Q2FGqG
        juAOVZ5R5Asut+RemrfsHIU=
X-Google-Smtp-Source: AGHT+IEBy8e1urSzEd5AfViADWXyjBwI/6pe9jPu0HQ36J4SzxdnrvUXOAh14Qui0bJ5ZdOI/rI99Q==
X-Received: by 2002:a17:903:288f:b0:1b8:9fc4:2733 with SMTP id ku15-20020a170903288f00b001b89fc42733mr1200146plb.3.1697687794149;
        Wed, 18 Oct 2023 20:56:34 -0700 (PDT)
Received: from sivslab-System-Product-Name ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902e80700b001c9b29b9bd4sm713524plg.38.2023.10.18.20.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 20:56:33 -0700 (PDT)
Date:   Thu, 19 Oct 2023 11:56:30 +0800
From:   Kuan-Wei Chiu <visitorckw@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/perf: Optimize find_alternatives_list() using
 binary search
Message-ID: <20231019035630.GC576715@sivslab-System-Product-Name>
References: <20231013175714.2142775-1-visitorckw@gmail.com>
 <871qdr75ie.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qdr75ie.fsf@mail.lhotse>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 12:41:45PM +1100, Michael Ellerman wrote:
> Kuan-Wei Chiu <visitorckw@gmail.com> writes:
> > This patch improves the performance of event alternative lookup by
> > replacing the previous linear search with a more efficient binary
> > search. This change reduces the time complexity for the search process
> > from O(n) to O(log(n)). A pre-sorted table of event values and their
> > corresponding indices has been introduced to expedite the search
> > process.
> 
> Thanks for the patch.
> 
> How did you test this? I assume you don't have a Power6 machine lying
> around? :)
> 
> cheers
> 

I indeed do not have a Power6 machine for testing. Therefore, I designed
a simple unit test [1] to verify the functionality of the patch. In this
test, I ran a loop from 0 to UINT_MAX, using these values as inputs to
compare the return values of the original function with the new function
I implemented, which utilizes binary search. If you have any suggestions
for a more suitable testing method, please let me know. I would greatly
appreciate your feedback.

Thanks,
Kuan-Wei Chiu

[1]:
/* return 0 on success and return non-zero on failure */
int test()
{
    u64 event = 0;
    for (u64 event = 0; event <= UINT_MAX; event++) {
        /* result of the current function in the linux kernel */
	int result_old = find_alternatives_list(event);
	/* result of the new function using binary search */
	int result_new = find_alternatives_list_new(event);

	if (result_old != result_new)
	    return 1;
    }
    return 0;
}


> > diff --git a/arch/powerpc/perf/power6-pmu.c b/arch/powerpc/perf/power6-pmu.c
> > index 5729b6e059de..b6030ea130eb 100644
> > --- a/arch/powerpc/perf/power6-pmu.c
> > +++ b/arch/powerpc/perf/power6-pmu.c
> > @@ -335,25 +335,34 @@ static const unsigned int event_alternatives[][MAX_ALT] = {
> >  	{ 0x3000fe, 0x400056 },			/* PM_DATA_FROM_L3MISS */
> >  };
> >  
> > -/*
> > - * This could be made more efficient with a binary search on
> > - * a presorted list, if necessary
> > - */
> >  static int find_alternatives_list(u64 event)
> >  {
> > -	int i, j;
> > -	unsigned int alt;
> > -
> > -	for (i = 0; i < ARRAY_SIZE(event_alternatives); ++i) {
> > -		if (event < event_alternatives[i][0])
> > -			return -1;
> > -		for (j = 0; j < MAX_ALT; ++j) {
> > -			alt = event_alternatives[i][j];
> > -			if (!alt || event < alt)
> > -				break;
> > -			if (event == alt)
> > -				return i;
> > -		}
> > +	const unsigned int presort_event_table[] = {
> > +		0x0130e8, 0x080080, 0x080088, 0x10000a, 0x10000b, 0x10000d, 0x10000e,
> > +		0x100010, 0x10001a, 0x100026, 0x100054, 0x100056, 0x1000f0, 0x1000f8,
> > +		0x1000fc, 0x200008, 0x20000e, 0x200010, 0x200012, 0x200054, 0x2000f0,
> > +		0x2000f2, 0x2000f4, 0x2000f5, 0x2000f6, 0x2000f8, 0x2000fc, 0x2000fe,
> > +		0x2d0030, 0x30000a, 0x30000c, 0x300010, 0x300012, 0x30001a, 0x300056,
> > +		0x3000f0, 0x3000f2, 0x3000f6, 0x3000f8, 0x3000fc, 0x3000fe, 0x400006,
> > +		0x400007, 0x40000a, 0x40000e, 0x400010, 0x400018, 0x400056, 0x4000f0,
> > +		0x4000f8, 0x600005};
> > +	const unsigned int event_index_table[] = {
> > +		0,  1,  2,  3,  4,  1, 5,  6,  7,  8,  9,  10, 11, 12, 13, 12, 14,
> > +		7,  15, 2,  9,  16, 3, 4,  0,  17, 10, 18, 19, 20, 1,  17, 15, 19,
> > +		18, 2,  16, 21, 8,  0, 22, 13, 14, 11, 21, 5,  20, 22, 1,  6,  3};
> > +	int lo = 0;
> > +	int hi = ARRAY_SIZE(presort_event_table) - 1;
> > +
> > +	while (lo <= hi) {
> > +		int mid = lo + (hi - lo) / 2;
> > +		unsigned int alt = presort_event_table[mid];
> > +
> > +		if (alt < event)
> > +			lo = mid + 1;
> > +		else if (alt > event)
> > +			hi = mid - 1;
> > +		else
> > +			return event_index_table[mid];
> >  	}
> >  	return -1;
> >  }
> > -- 
> > 2.25.1
