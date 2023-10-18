Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D494B7CD669
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344208AbjJRI2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjJRI2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:28:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4B5B6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697617675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5myctI+T5Cg08XOlMTBvgWtZvdhuo39M1fwXVkEoAQw=;
        b=U7eb8SjIjUZhWqnh3HRF/Jb5+qMXIScyF6YRY3mBb6bTymXaQlJtuo97zMJBBVTFpRB527
        fmOoXMun8xxZqkPsumiHzYY/kVqAWpKjAukXggtdHICxwsey3WnKfG/SSgEcBw+tGVL8NA
        GG6l6H/fkEmA8U+w4MHM6lk2HUdh9pw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-kImvH6ylMo-93mozWdR-hQ-1; Wed, 18 Oct 2023 04:27:33 -0400
X-MC-Unique: kImvH6ylMo-93mozWdR-hQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5079a8c68c6so5013009e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697617652; x=1698222452;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5myctI+T5Cg08XOlMTBvgWtZvdhuo39M1fwXVkEoAQw=;
        b=qwGKDh0Su3tvmSd8InTVsMT10sJ89n5m4pERbjKDXb4ByF36KP6SveEMMjlPK5dqe2
         NDSZadcURapRVjUAFBtTghWmZjNvjSVO7GLsjqaz3z3FA/uFc5iyr97NV/y3jfl0XMUs
         chiQJDb9odv3q7w38AHFwDB9kCW6HsrGffDnt/MreM3Mbb/U8TKhrd9bHCNq6jgB7kRb
         U7R7x6iNRmpJp4DEed8lIbzbfBxvAhOBkEwlwKMcZmYZ+J0EQRVvkVK3hnrmMi99zFQl
         ibSomq0sb4r781qE0pEI8I3hV7rJnJjZTdAH/f8y7/M/Dzw0alEzxL/07YGaHjPUtWNm
         73dg==
X-Gm-Message-State: AOJu0YwBxe2tgo5+JzhtDkEVr7avmScq9SOij6T6O9fpRZM6Lap1Src0
        L1ym+/cHTKOvlYbIzmd2OrZZzWyhACPAtjTwb4SbY0TkDE5Yp+OJUSjj1fhPmSuE7zmMlKUS0lj
        5hMuLzpofaPYlViBARvud5r7H
X-Received: by 2002:a05:6512:3b0c:b0:507:9693:12aa with SMTP id f12-20020a0565123b0c00b00507969312aamr4713182lfv.15.1697617652409;
        Wed, 18 Oct 2023 01:27:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIrJgfOZ5wI3NwKzoPhuc2u3+jMX/qHA84uKjhekRit/zjddhWIi74k2GsOXWGi2hyuIJALw==
X-Received: by 2002:a05:6512:3b0c:b0:507:9693:12aa with SMTP id f12-20020a0565123b0c00b00507969312aamr4713172lfv.15.1697617652089;
        Wed, 18 Oct 2023 01:27:32 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id f15-20020a05640214cf00b0053e88c4d004sm2355554edx.66.2023.10.18.01.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 01:27:31 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Angelina Vu <angelinavu@linux.microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH] hv_balloon: Add module parameter to configure balloon
 floor value
In-Reply-To: <BYAPR21MB1688AD7F27C9CA40F7FB4EF1D7D6A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1696978087-4421-1-git-send-email-angelinavu@linux.microsoft.com>
 <87jzrl71me.fsf@redhat.com>
 <BYAPR21MB1688AD7F27C9CA40F7FB4EF1D7D6A@BYAPR21MB1688.namprd21.prod.outlook.com>
Date:   Wed, 18 Oct 2023 10:27:30 +0200
Message-ID: <878r8072tp.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael Kelley (LINUX)" <mikelley@microsoft.com> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Tuesday, October 17, 2023 7:41 AM
>> 
>> Angelina Vu <angelinavu@linux.microsoft.com> writes:
>> 
>> > Currently, the balloon floor value is automatically computed, but may be
>> > too small depending on app usage of memory. This patch adds a balloon_floor
>> > value as a module parameter that can be used to manually configure the
>> > balloon floor value.
>> >
>> > Signed-off-by: Angelina Vu <angelinavu@linux.microsoft.com>
>> > ---
>> >  drivers/hv/hv_balloon.c | 7 +++++++
>> >  1 file changed, 7 insertions(+)
>> >
>> > diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
>> > index 64ac5bdee3a6..87b312f99b2e 100644
>> > --- a/drivers/hv/hv_balloon.c
>> > +++ b/drivers/hv/hv_balloon.c
>> > @@ -1101,6 +1101,10 @@ static void process_info(struct hv_dynmem_device *dm,
>> struct dm_info_msg *msg)
>> >  	}
>> >  }
>> >
>> > +unsigned long balloon_floor;
>> > +module_param(balloon_floor, ulong, 0644);
>> > +MODULE_PARM_DESC(balloon_floor, "Memory level (in megabytes) that ballooning
>> will not remove");
>> > +
>> >  static unsigned long compute_balloon_floor(void)
>> >  {
>> >  	unsigned long min_pages;
>> > @@ -1117,6 +1121,9 @@ static unsigned long compute_balloon_floor(void)
>> >  	 *    8192       744    (1/16)
>> >  	 *   32768      1512	(1/32)
>> >  	 */
>> > +	if (balloon_floor)
>> > +		return MB2PAGES(balloon_floor);
>> > +
>> >  	if (nr_pages < MB2PAGES(128))
>> >  		min_pages = MB2PAGES(8) + (nr_pages >> 1);
>> >  	else if (nr_pages < MB2PAGES(512))
>> 
>> A module parameter is probably useful for debugging but it can hardly be
>> applied in production environments as it must be 'one size fits all' and
>> e.g. for different VM sizes it can be different (that's the purpose of
>> compute_balloon_floor() heuristics).
>> 
>> In fact, does it has to be statically set? Can we have a sysfs entity so
>> this can be a policy (userspace decision)? We can keep the current
>> compute_balloon_floor() as the default but users will be able to adjust
>> accordingly.
>> 
>
> The module parameter can also be set or changed at runtime via
> /sys/module/balloon/parameters/balloon_floor.  Changes made by
> writing to that path are immediately reflected in the value of
> the balloon_floor variable.  I think that accomplishes everything
> you've outlined while also allowing a value to be set on the
> kernel boot line.

Oh, thanks, I've actually forgot it is r/w. What's IMO not ideal with
this approach is that if you don't pass any value on the kernel command
line, '/sys/module/balloon/parameters/balloon_floor' will contain '0' so
the user will have to guess the actual current value. Would it make
sense to do:

  if (!balloon_floor)
          balloon_floor = compute_balloon_floor();

on boot/whenever(if) totalram_pages() changes? Personally, I'm not sure
it's a good idea as I've never seen kernel module parameters which would
behave this way :-) Another thing is that I'm not sure to which extent
'/sys/module/*/parameters/' can be considered a stable ABI, i.e. it is
not documented like Documentation/ABI/stable/*.

-- 
Vitaly

