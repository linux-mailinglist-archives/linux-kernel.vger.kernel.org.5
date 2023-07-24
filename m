Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3B57602F1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 01:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjGXXEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 19:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjGXXEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 19:04:30 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11919170E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 16:04:29 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-76714caf466so453880785a.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 16:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690239867; x=1690844667;
        h=to:references:message-id:date:cc:in-reply-to:from:mime-version
         :subject:content-transfer-encoding:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LXtorpou+Rntqb6dTPTasH604CVMh1dch7l87Dmks4=;
        b=ZeDVrssVR9RnInRKhSi2QDZnnuNdmhZWng4oqfa/1pgNVbWCyhKMkSX2Bi/Pz5wBNo
         gjw7gyl11AZJAC19mXP7OfVb7AqoBPGSrRGyKv4jp1EG8IWbKc00PsOya3xxMPSh8ahD
         9RLy5xi53au7LFW15WmkTj/e3tDD7aehtTXUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690239867; x=1690844667;
        h=to:references:message-id:date:cc:in-reply-to:from:mime-version
         :subject:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2LXtorpou+Rntqb6dTPTasH604CVMh1dch7l87Dmks4=;
        b=f7q4mXzoUBzK3idvH0PG40HFn/k6HUWz+n7YvWySuAQM2JEWJOeIo4PX0KjTTnHqi3
         oSzMCPi2GPHdansJMGR/uFO1x2AdfrXXe5JGjxNJQx31YfGIuoMRZ6908KWXxngINBCw
         upO/VcvRfOss7zuTfbaaBbz/YIiatu2zPj9bg1lV4w7Kawrzhvntdrdujqsh7xxq0YU7
         hEGjK/vtEmkopTnlFRwhdVA49mPyd9V/E+1RraXS75U4gzL9FScLr/N7xzNP8Juy+wpC
         JeqVl0HMqErPQthVwQ/6XH+eRyrRx5AQoDGlLhNSpkU9utokDQM8b47NuxuV7b2YiHjV
         nnww==
X-Gm-Message-State: ABy/qLbyvh5cOLuS0/sJl+Yhs1YN9jEddTZsZ9CZ/c8oo7b2BAImwZMo
        vQUyFYhJc7iOmtTRCynRsIjv7TwffZ/gVWZg/hM=
X-Google-Smtp-Source: APBJJlGPAEEJq51dg5WK/pI1EJhqLCwRfejHDT1BUIqI7Qy6/6W93B4v/VTAm+MwO2pEvj8jnWjcNA==
X-Received: by 2002:a0c:f051:0:b0:632:2e63:d34b with SMTP id b17-20020a0cf051000000b006322e63d34bmr282386qvl.14.1690239867204;
        Mon, 24 Jul 2023 16:04:27 -0700 (PDT)
Received: from smtpclient.apple ([192.145.116.44])
        by smtp.gmail.com with ESMTPSA id bn9-20020a05620a2ac900b00767e2668536sm3314658qkb.17.2023.07.24.16.04.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 16:04:25 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [BUG] Re: Linux 6.4.4
Mime-Version: 1.0 (1.0)
X-Apple-Notify-Thread: NO
X-Universally-Unique-Identifier: EB10CBA5-D87D-47AD-8CB1-4ED1C1201EB1
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <4b231ce5-7bb8-4abf-9c40-04aa676d1e45@paulmck-laptop>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        rcu@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Date:   Mon, 24 Jul 2023 19:04:14 -0400
X-Apple-Message-Smime-Encrypt: NO
Message-Id: <123C6650-490B-4D08-96B4-39B118AD0054@joelfernandes.org>
References: <4b231ce5-7bb8-4abf-9c40-04aa676d1e45@paulmck-laptop>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 24, 2023, at 12:00 PM, Paul E. McKenney <paulmck@kernel.org> wrote:=

>=20
> =EF=BB=BFOn Mon, Jul 24, 2023 at 09:36:02AM -0400, Joel Fernandes wrote:
>>> On Sun, Jul 23, 2023 at 11:35=E2=80=AFPM Paul E. McKenney <paulmck@kerne=
l.org> wrote:
>>>=20
>>> On Mon, Jul 24, 2023 at 12:32:57AM +0000, Joel Fernandes wrote:
>>>> On Sun, Jul 23, 2023 at 10:19:27AM -0700, Paul E. McKenney wrote:
>>>>> On Sun, Jul 23, 2023 at 10:50:26AM -0400, Joel Fernandes wrote:
>>>>>>=20
>>>>>>=20
>>>>>> On 7/22/23 13:27, Paul E. McKenney wrote:
>>>>>> [..]
>>>>>>>=20
>>>>>>> OK, if this kernel is non-preemptible, you are not running TREE03,
>>>>>>> correct?
>>>>>>>=20
>>>>>>>> Next plan of action is to get sched_waking stack traces since I hav=
e a
>>>>>>>> very reliable repro of this now.
>>>>>>>=20
>>>>>>> Too much fun!  ;-)
>>>>>>=20
>>>>>> For TREE07 issue, it is actually the schedule_timeout_interruptible(1=
)
>>>>>> in stutter_wait() that is beating up the CPU0 for 4 seconds.
>>>>>>=20
>>>>>> This is very similar to the issue I fixed in New year in d52d3a2bf408=

>>>>>> ("torture: Fix hang during kthread shutdown phase")
>>>>>=20
>>>>> Agreed, if there are enough kthreads, and all the kthreads are on a
>>>>> single CPU, this could consume that CPU.
>>>>>=20
>>>>>> Adding a cond_resched() there also did not help.
>>>>>>=20
>>>>>> I think the issue is the stutter thread fails to move spt forward
>>>>>> because it does not get CPU time. But spt =3D=3D 1 should be very bri=
ef
>>>>>> AFAIU. I was wondering if we could set that to RT.
>>>>>=20
>>>>> Or just use a single hrtimer-based wait for each kthread?
>>>>=20
>>>> [Joel]
>>>> Yes this might be better, but there's still the issue that spt may not b=
e set
>>>> back to 0 in some future release where the thread gets starved.
>>>=20
>>> But if each thread knows the absolute time at which the current stutter
>>> period is supposed to end, there should not be any need for the spt
>>> variable, correct?
>>=20
>> Yes.
>>=20
>>>>>> But also maybe the following will cure it like it did for the shutdow=
n
>>>>>> issue, giving the stutter thread just enough CPU time to move spt for=
ward.
>>>>>>=20
>>>>>> Now I am trying the following and will let it run while I go do other=

>>>>>> family related things. ;)
>>>>>=20
>>>>> Good point, if this avoids the problem, that gives a strong indication=

>>>>> that your hypothesis on the root cause is correct.
>>>>=20
>>>> [Joel]
>>>> And the TREE07 issue is gone with that change!
>> [...]
>>>> Let me know what you think, thanks!
>>>=20
>>> If we can make the stutter kthread set an absolute time for the current
>>> stutter period to end, then we should be able to simplify the code quite=

>>> a bit and get rid of the CPU consumption entirely.  (Give or take the
>>> possible need for a given thread to check whether it was erroneously
>>> awakened early.)
>>>=20
>>> But what specifically did you have in mind?
>>=20
>> I was thinking of a 2 counter approach storing the absolute time. Use
>> an alternative counter for different stuttering sessions. But yes,
>> generally I agree with the absolute time idea. What do you think Paul?
>>=20
>> Do we want to just do  the simpler schedule_timeout at HZ / 20 to keep st=
able
>> green, and do the absolute-time approach for mainline? That might be bett=
er
>> from a process PoV. But I think stable requires patches to be upstream. G=
reg?
>>=20
>> I will try to send out patches this week to discuss this, thanks,
>=20
> Heh!!!
>=20
> Me, I was just thinking of mainline.  ;-)

Turns out it is simple enough for both mainline and stable :-).
Will test more and send it out soon.

Thanks,

- Joel


>=20
>                            Thanx, Paul
