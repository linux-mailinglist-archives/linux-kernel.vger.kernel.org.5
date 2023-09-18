Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65797A4977
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241336AbjIRMWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241970AbjIRMVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:21:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED32DE
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695039666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E5iqxcEoFL+nI91XzTtwFeU0EzRStoTmjKrAt0kFCFY=;
        b=ckpEYUsCC8+RHlWMWy+4bq3LFQdc/feUsBQO9CG5WN3pDkIoPQsCguaOjBuUIlW9n2923/
        6S2quxITV6WgX/nUJhItr0AsmEs4i9Q0BhvUKbEy9oOd0ePB+L9U3c89BERLpuIOdlhRvr
        8cZwNPsIlpR+8asroM6KyUm555n8mh4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-T3HKI-YIP0q386tDpRlCKg-1; Mon, 18 Sep 2023 08:21:05 -0400
X-MC-Unique: T3HKI-YIP0q386tDpRlCKg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-32009388bb6so1006755f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695039664; x=1695644464;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E5iqxcEoFL+nI91XzTtwFeU0EzRStoTmjKrAt0kFCFY=;
        b=f52HdAOfN4uNMy07beRURAY2tDqkdTfMKR5fe1e9wt2iVpBW4zJ4AHqjd1q50VJfB0
         2a2YjZU+VQ2NcqM/5DkO6+xWpSm4vXP21apbAcdWUVhz1eDSWb3Z/bakHYrANmCNJBS1
         WCiQJvUsm6oHpAMGyywVepFmbq7s77Z8nwre0/trbl8hLKnxBaGup/rOPTuX7VFbw8q2
         n5WCDAi0i29V3DYst+urPQQjLbyRVvDw5off8kpGnzmwK4eLNbQ4cjX8emlgTu3UWMG7
         M3OebLMTZ0yeYq77spsSjEc92ekHcCi0g+Ft9luAUJ6gRE3ALJpSO0gMA9q2KRTcLKq0
         AwKQ==
X-Gm-Message-State: AOJu0YywFaQ5PNx4PZTX8zRIHcXv0jI8jgiUM6EvOaUnZkScMFzAa+Kx
        +N9odpBqsAAWawt5X+DloLXfUqWjA7/ekrX4SC+PqKbV6I4y77PWwk5F9r+1CbIQgqq8GR1Uc4q
        a2PQoU16Cb67HoWDE8OCzeEMh
X-Received: by 2002:a05:6000:12ce:b0:316:e249:c285 with SMTP id l14-20020a05600012ce00b00316e249c285mr7502451wrx.71.1695039663843;
        Mon, 18 Sep 2023 05:21:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWGr8ikdKyB1diJTGmOzil5UyJNpYhns+7WYWnPWeYC32jlgGUasly/JwonHWNRQ41dX265Q==
X-Received: by 2002:a05:6000:12ce:b0:316:e249:c285 with SMTP id l14-20020a05600012ce00b00316e249c285mr7502436wrx.71.1695039663554;
        Mon, 18 Sep 2023 05:21:03 -0700 (PDT)
Received: from vschneid.remote.csb (anice-256-1-26-111.w86-203.abo.wanadoo.fr. [86.203.135.111])
        by smtp.gmail.com with ESMTPSA id f4-20020adfdb44000000b00318147fd2d3sm12653529wrj.41.2023.09.18.05.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 05:21:02 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Pierre Gondois <pierre.gondois@arm.com>,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc:     dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, quentin.perret@arm.com,
        srikar@linux.vnet.ibm.com, mgorman@techsingularity.net,
        mingo@kernel.org, yu.c.chen@intel.com, tim.c.chen@linux.intel.com,
        mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org
Subject: Re: [PATCH v3] sched/topology: remove sysctl_sched_energy_aware
 depending on the architecture
In-Reply-To: <ff3a1e32-74c3-56bc-94dc-78d088faf8b7@arm.com>
References: <20230913114807.665094-1-sshegde@linux.vnet.ibm.com>
 <xhsmhil8cvi7s.mognet@vschneid.remote.csb>
 <7c6dd2ec-b9a9-b364-5a29-05336127e519@linux.vnet.ibm.com>
 <xhsmhfs3fve7k.mognet@vschneid.remote.csb>
 <ff3a1e32-74c3-56bc-94dc-78d088faf8b7@arm.com>
Date:   Mon, 18 Sep 2023 14:21:01 +0200
Message-ID: <xhsmhbkdzvfiq.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/23 15:35, Pierre Gondois wrote:
> Hello Valentin,
>
> On 9/15/23 14:00, Valentin Schneider wrote:
>> On 14/09/23 23:26, Shrikanth Hegde wrote:
>>> On 9/14/23 9:51 PM, Valentin Schneider wrote:
>>>> On 13/09/23 17:18, Shrikanth Hegde wrote:
>>>>> sysctl_sched_energy_aware is available for the admin to disable/enable
>>>>> energy aware scheduling(EAS). EAS is enabled only if few conditions are
>>>>> met by the platform. They are, asymmetric CPU capacity, no SMT,
>>>>> valid cpufreq policy, frequency invariant load tracking. It is possible
>>>>> platform when booting may not have EAS capability, but can do that after.
>>>>> For example, changing/registering the cpufreq policy.
>>>>>
>>>>> At present, though platform doesn't support EAS, this sysctl is still
>>>>> present and it ends up calling rebuild of sched domain on write to 1 and
>>>>> NOP when writing to 0. That is confusing and un-necessary.
>>>>>
>>>>
>>>
>>> Hi Valentin, Thanks for taking a look at this patch.
>>>
>>>> But why would you write to it in the first place? Or do you mean to use
>>>> this as an indicator for userspace that EAS is supported?
>>>>
>>>
>>> Since this sysctl is present and its value being 1, it gives the
>>> impression to the user that EAS is supported when it is not.
>>> So its an attempt to correct that part.
>>>
>> 
>> Ah, I see. Then how about just making the sysctl return 0 when EAS isn't
>> supported? And on top of it, prevent all writes when EAS isn't supported
>> (perf domains cannot be built, so there would be no point in forcing a
>> rebuild that will do nothing).
>
> I think the issue comes from the fact there is no variable representing
> whether EAS is supported or not. sched_energy_enabled()/sched_energy_present
> tells whether EAS is actively running on the system instead.
>
> So on a system with EAS running, I think what would happen is:
> # Disable EAS and set sched_energy_present=0
> echo 0 > /proc/sys/kernel/sched_energy_aware
>
> # sched_energy_present==0, so we get -EOPNOTSUPP
> echo 1 > /proc/sys/kernel/sched_energy_aware
>

Ah, quite so, I didn't think this through!

