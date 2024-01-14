Return-Path: <linux-kernel+bounces-25534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC31982D203
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 20:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3EB1F214F5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 19:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA7512E5E;
	Sun, 14 Jan 2024 19:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="XsV6nra+"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFD2101D2
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 19:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bd576ec101so2445424b6e.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 11:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1705262301; x=1705867101; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D/YR4hj/qQuit7GleqNYXarnoR7eAKI7GLc9kLmumSA=;
        b=XsV6nra+pJfMJwjHTV8IW0KrPqY87vMh3O1nuU+145xH9yth9XBDqHoUz8/T+x7oGp
         tupOMKprLhzFqj+kJsWUAYAB82eqRZZed1fTPygwNYutdxytwHqycN9T1YhYouzfREAx
         mKPcURz3YrMzHzL3enLpuNBDzjxuEvcYGV2cSI4z3HSHO5/fmCCunevWFVya8zbd8Lyg
         rxyYxIdwPRcb+sOCONXd5jeZ0sK2nUmi2TTF3Ue6Wef63YdXegFSkK54gDyAKJntgeR9
         CVJtmCfP0rk+S23YLNZc/y5llLqwqcA8aNOwKHISh3hXo9n2/8aywKjz+5M0/kRfJbrv
         gh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705262301; x=1705867101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/YR4hj/qQuit7GleqNYXarnoR7eAKI7GLc9kLmumSA=;
        b=hmqJFBj3v+b/eq+kA24wVcpXOPXjtQWfyo225TEyx4jTt9i6uaxZjUW46APjp4G3tf
         ugQrpfaUKOVwMJEmFeS6u8G5/w43Kt6Ha05sGnr4WRaTMfEhkWFWai+KyqRgocR8frlU
         q075OzkLhHH0mBtxWxCsKk8cxprixPYnSzJhnGwEUBFYKkh4QVk3PwfkGI7ZZ64GzLrD
         8VuZgSvz3dcrZwGWrdBBr3rZIlNDcGWTSZ4Kk5OtUEpX0HEX82QbWnqBR5lp3GjYoymi
         ztguox4JKynCfJvbsxDTXtb+ucAzhWUdmmly7vnmYhzm9b1nzhRu1cZ+MEs2QZ+oYRnr
         JzfA==
X-Gm-Message-State: AOJu0YybwhBXxEcKStkjzGa4mqJgaPXx/DNpmkCRl5d/CaMmvHV+I71x
	1wGB7FgKnCH7ZU7mi4+/O9lJH4kZgbYy3yNIDB9ir3lgxC0=
X-Google-Smtp-Source: AGHT+IHaiOJtCRoc7CtaB/zwAwh4yMzxzqFYaULtimXrEvsfVBNU7bdfvZfCmUbAurMMoavqalBeyg==
X-Received: by 2002:a05:6808:6508:b0:3bd:6866:7be4 with SMTP id fm8-20020a056808650800b003bd68667be4mr5180902oib.17.1705262301304;
        Sun, 14 Jan 2024 11:58:21 -0800 (PST)
Received: from airbuntu (host109-154-205-127.range109-154.btcentralplus.com. [109.154.205.127])
        by smtp.gmail.com with ESMTPSA id lf8-20020a170902fb4800b001d5b2967d00sm3154041plb.290.2024.01.14.11.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 11:58:20 -0800 (PST)
Date: Sun, 14 Jan 2024 19:58:15 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Wyes Karny <wkarny@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [GIT PULL] Scheduler changes for v6.8
Message-ID: <20240114195815.nes4bn53tc25djbh@airbuntu>
References: <ZZwBi/YmnMqm7zrO@gmail.com>
 <CAHk-=wgWcYX2oXKtgvNN2LLDXP7kXkbo-xTfumEjmPbjSer2RQ@mail.gmail.com>
 <CAHk-=wiXpsxMcQb7MhL-AxOityTajK0G8eWeBOzX-qBJ9X2DSw@mail.gmail.com>
 <CAHk-=wjK28MUqBZzBSMEM8vdJhDOuXGSWPmmp04GEt9CXtW6Pw@mail.gmail.com>
 <20240114091240.xzdvqk75ifgfj5yx@wyes-pc>
 <ZaPC7o44lEswxOXp@vingu-book>
 <20240114123759.pjs7ctexcpc6pshl@wyes-pc>
 <CAKfTPtCz+95dR38c_u6_7JbkVt=czj5N2dKYVV-zk9dgbk16hw@mail.gmail.com>
 <20240114151250.5wfexq44o3mdm3nh@airbuntu>
 <CAKfTPtAMxiTbvAYav1JQw+MhjzDPCZDrMLL2JOfsc0GWp+FnOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="shmrmzvrjnjefmku"
Content-Disposition: inline
In-Reply-To: <CAKfTPtAMxiTbvAYav1JQw+MhjzDPCZDrMLL2JOfsc0GWp+FnOA@mail.gmail.com>


--shmrmzvrjnjefmku
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On 01/14/24 16:20, Vincent Guittot wrote:
> On Sun, 14 Jan 2024 at 16:12, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 01/14/24 14:03, Vincent Guittot wrote:
> >
> > > Thanks for the trace. It was really helpful and I think that I got the
> > > root cause.
> > >
> > > The problem comes from get_capacity_ref_freq() which returns current
> > > freq when arch_scale_freq_invariant() is not enable, and the fact that
> > > we apply map_util_perf() earlier in the path now which is then capped
> > > by max capacity.
> > >
> > > Could you try the below ?
> > >
> > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > > index e420e2ee1a10..611c621543f4 100644
> > > --- a/kernel/sched/cpufreq_schedutil.c
> > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > @@ -133,7 +133,7 @@ unsigned long get_capacity_ref_freq(struct
> > > cpufreq_policy *policy)
> > >         if (arch_scale_freq_invariant())
> > >                 return policy->cpuinfo.max_freq;
> > >
> > > -       return policy->cur;
> > > +       return policy->cur + policy->cur >> 2;
> > >  }
> > >
> > >  /**
> >
> > Is this a test patch or a proper fix? I can't see it being the latter. It seems
> 
> It's a proper fix. It's the same mechanism that is used already :
>  - Either you add margin on the utilization to go above current freq
> before it is fully used. This si what was done previously
>  - or you add margin on the freq range to select a higher freq than
> current one before it become fully used

Aren't we applying the 25% headroom twice then?

> 
> > the current logic fails when util is already 1024, and I think we're trying to
> > fix the invariance issue too late.
> >
> > Is the problem that we can't read policy->cur in the scheduler to fix the util
> > while it's being updated that's why it's done here in this case?
> >
> > If this is the problem, shouldn't the logic be if util is max then always go to
> > max frequency? I don't think we have enough info to correct the invariance here
> > IIUC. All we can see the system is saturated at this frequency and whether
> > a small jump or a big jump is required is hard to tell.
> >
> > Something like this
> >
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 95c3c097083e..473d0352030b 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -164,8 +164,12 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
> >         struct cpufreq_policy *policy = sg_policy->policy;
> >         unsigned int freq;
> >
> > -       freq = get_capacity_ref_freq(policy);
> > -       freq = map_util_freq(util, freq, max);
> > +       if (util != max) {
> > +               freq = get_capacity_ref_freq(policy);
> > +               freq = map_util_freq(util, freq, max);
> > +       } else {
> > +               freq = policy->cpuinfo.max_freq;
> > +       }
> 
> This is not correct because you will have to wait to reach full
> utilization at the current OPP possibly the lowest OPP before moving
> directly to max OPP

Isn't this already the case? The ratio (util+headroom/max) will be less than
1 until util is 80% (with 25% headroom). And for all values <= 80% * max, we
will request a frequency smaller than/equal policy->cur, no?

ie:

	util = 600
	max = 1024

	freq = 1.25 * 600 * policy->cur / 1024 = 0.73 * policy->cur

(util+headroom/max) must be greater than 1 for us to start going above
policy->cur - which seems to have been working by accident IIUC.

So yes my proposal is incorrect, but it seems the conversion is not right to me
now.

I could reproduce the problem now (thanks Wyes!). I have 3 freqs on my system

2.2GHz, 2.8GHz and 3.8GHz

which (I believe) translates into capacities

~592, ~754, 1024

which means we should pick 2.8GHz as soon as util * 1.25 > 592; which
translates into util = ~473.

But what I see is that we go to 2.8GHz when we jump from 650 to 680 (see
attached picture), which is what you'd expect since we apply two headrooms now,
which means the ratio (util+headroom/max) will be greater than 1 after go above
this value

	1024 * 0.8 * 0.8 = ~655

So I think the math makes sense logically, but we're missing some other
correction factor.

When I re-enable CPPC I see for the same test that we go into 3.8GHz straight
away. My test is simple busyloop via

	cat /dev/zero > /dev/null

I see the CPU util_avg is at 523 at fork. I expected us to run to 2.8GHz here
to be honest, but I am not sure if util_cfs_boost() and util_est() are maybe
causing us to be slightly above 523 and that's why we start with max freq.

Or I've done the math wrong :-) But the two don't behave the same for the same
kernel with and without CPPC.

> 
> >
> >         if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
> >                 return sg_policy->next_freq;

--shmrmzvrjnjefmku
Content-Type: image/png
Content-Disposition: attachment; filename="cppc_freq_fix.png"
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAACh0AAADrCAIAAAD4lVLYAAAACXBIWXMAAA7EAAAOxAGVKw4b
AAAgAElEQVR4nOzdeXxU1f3/8c+dJTPZQ/aQBBIIWwgk7GFXREBRWSQqVlwr6k/a0u3bWm3V
fq3Wb2tdsRZtVbQoVhEQFRdklSUQCFuAhBBCyEL2hCwzyWTu74+JaUjCQCBk5sLr+eCPO2fu
ufOZ+zbjSc7ccxVVVQW4IixdulREFi5c6OpCrgpLly7lVGsaCWodCWoa8WkdCWoa8WkdCWod
CWoa8WkdCWoa8WkdCWodCWoa8WkdCbpE4tu1B+7v0b7d0P2lAAAAAAAAAAAAAADckyrNVyYr
orRsG9asWTN16lQvL68zZ858++23jY2N8fHxCQkJLd3at7/77ruKoohIYmJiYmJiy565ubkH
DhxITk4ODg4uLCzcunWro72qqmrevHkBAQHd8z4BuMSePXuOHTtmNps79ZHS1NT03XffVVRU
hIaGTp482fHZIiLt2w8fPnzgwAERSU5O7tWrl2ve5BWNBLWOBDWN+LSOBDWN+LSOBLWOBDWN
+LSOBDWN+LSOBLWOBDWN+LSOBLuLXUSk1aSyiOhiY2MdZ2fv3r0JCQlz5849cOCA1Wpt2aNN
u91uN5lMd99999133916Ujk7O/vkyZMWi8WxsHZERERKSkpKSsrNN98cEBBwKZPK69evb2xs
vOjuALpBTU1Ndnb2vHnzOvuRcvz4cZPJdNtttzU0NJw6dapltzbt9fX16enpc+fOnTJlyo4d
O1zwDq90JKh1JKhpxKd1JKhpxKd1JKh1JKhpxKd1JKhpxKd1JKh1JKhpxKd1JNiN7CJ2kaYf
/tlFVF3Pnj1LS0tFpLS0tGfPngaDISgoqKKi4ujRo1u2bGnfbrFYzGZz66OuWLHizJkzffv2
nThxoslkavOaWVlZffr0uZSqS0pKuAk04ObKysrCwsJ0uk5/pJSVlUVERIhIRERESUmJ/PCR
0r593LhxBoPB19eXL5pcDiSodSSoacSndSSoacSndSSodSSoacSndSSoacSndSSodSSoacSn
dSToWgaj0WixWETEarUajUYRMRgMFoslLi4uJiamfbuHh0d1dfXy5cv9/Pyuu+46T0/Pm2++
2cvL61wvkJmZOW3atG56NwBcxGq1GgwGEensR0rLQ6PRWFNTIyKOj5Q27Z6enr179xaRnJwc
x3HQtUhQ60hQ04hP60hQ04hP60hQ60hQ04hP60hQ04hP60hQ60hQ04hP60jQpVSdiLSsId5C
URS9Xt/+4mNFUXx9fadMmXLHHXcEBgbu379fRJxMKpeWlhqNRl9f34urLjU19Z133jlz5szy
5cvXrVt3cQcB0M069ZHSejUCR0fHR0r7dhGpqalJT08fPnz45SgbLUhQ60hQ04hP60hQ04hP
60hQ60hQ04hP60hQ04hP60hQ60hQ04hP60iwe6kiqq6hocFxfk0mU0NDg4g0Nja2PuNt2h2X
lut0ut69e1dVVTl/hczMzH79+l10gaNHj7733nt9fX3vvPPOGTNmXPRxAFxuZrPZsSJEZz9S
2nc81wHtdvv69evHjRvn6enZre/t6kCCWkeCmkZ8WkeCmkZ8WkeCWkeCmkZ8WkeCmkZ8WkeC
WkeCmkZ8WkeCrqUrKCgICQkRkeDg4IKCApvNVlZWFhgYaLPZHHe3btOem5u7efNmESkpKfH3
9xeRurq6Dg9tt9tzcnIu8ebKADQhKCjo9OnTdru9sx8pwcHB+fn5IlJQUBAcHCw/fKS0b9+5
c2dERESvXr1c+DavYCSodSSoacSndSSoacSndSSodSSoacSndSSoacSndSSodSSoacSndSTo
WvobbrghOTnZaDQGBgampqYePHgwISEhIiIiMzMzKyurd+/ebdoDAgKOHz++e/fu+vr6sWPH
Go3GTz75pHfv3o45/MzMzKioKG9vbxHJzc21WCwDBgy4xBITEhL0en0XvFdc6dLS0kRkxIgR
ri7kqpCWltb6VHt4eFit1i1bttTW1nbqI8Xf3z87OzstLc3Pz2/o0KGKojg+UkJDQ1u319fX
f/vttxaLJSMjIyMjIzQ01PE5g4tGglpHgppGfFpHgppGfFpHglpHgppGfFpHgppGfFpHglpH
gppGfFpHgi7xRnrj6dXPtm8/az1xQNOWLl0qIgsXLnR1IVeFpUuXcqo1jQS1jgQ1jfi0jgQ1
jfi0jgS1jgQ1jfi0jgQ1jfi0jgS1jgQ1jfi0jgRdIvHt2v33+7Rv13V/KQAAAAAAAAAAAAAA
DTGsW7fu+uuv1+v1+/fvz8jI8PPzu/76641Go81m27x58+nTp++44w5FURx7nzx5cufOnaqq
jh49OiYmRlXVnJyc9PT0m2++2Wg0pqenZ2VliYjNZgsKCpo2bZqj18aNG4uLi729vadPn24w
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
Nua+/npgcbGInOnRozQy0q+8PDYjIzYjI3XatG033NCFffunp0/98EMPq1UUpSI4uDw01NjY
6F9aGpKfn/j99znx8asffPAyvUdcbeLj4318fN58882EhITx48evXbt23LhxxcXFq1evTklJ
6dOnz+bNm728vE6dOtXhpLKIJCcnf//997NnzxYRDw8PVVUbGxtFpL6+3tvbu32LiFitVp2O
ZdXci66p6aa33w4qLBSRJoPhs/vvL3d6kToAAACAK5EiokrreeV/Lf90w9ZUby/PyIjQxQ8t
8PXxvrgD//Sx5yqrqh3b826ZdsuMa1s/W1V9ZsuOPWNHJZ33OH/8698f+NGtkRFn/bryyz/8
5Znf/WTo4P7/+vfKRT9mWvGq8EDKxJ88vbx9o0uKAQAAANqzenqmXn/9oTFjqoKCRERR1aQt
WyZ/+unor78+MXBgm8uIL7pvv/T0G5ctE5E9kyenXXddra+vo11R1YicnOGbNkWeY3oPuAjh
4eGZmZk2m+3w4cOOa47T0tIsFovNZistLfXy8nLePSoqSlXVoqIix0O9Xq+qqmPbbrfrdLr2
LZftreCSTF2xIjozU0RURfl6/vz8vn1dXREAAACA7tHm1zS7iNo8r/zl+q0VFVXLljyrKMqm
bbtfe+uDxxb/+OJexGg0LHv9uXM9+9Hqr26fc54v7DssfuhuP9+O57YjwkIabbbi0vLQ4MCL
KxIakhQffYGNAAAAgEt8vGhRk+G/39lVFWXvpEkRJ07037u3f3q683nlC+xrrqu7fsUKUdUN
c+fum3jWlyxVRSno06egT5+orptX9rBab12y5PCoURmjRzeYTF11WGiI2Wx2XExstVozMjJE
xG63T5s2LSAgwMfHp7i42Hn35OTkHTt2tDxsampSFMWxrSiKzWZr33JZ3gYuTfK6dfG7djm2
t91449Hhw11bDwAAAIBupLTaVh0NzX+/+PzrTc8/+QvHL3WTx418/z+fqara8jte5/zwjeOO
nlGzc/J6L4i4kMOca1LZYeqksevWb7379ls6XR4AAAAAdKnWE8MtCmNi+u/d61Vd3SV9h27b
5mGxnI6ObjOp3Nqpi72O0LO29qEnnmjfHpaXN/nTT9MnTUqfMKGq3U2acWWzWCxGo1FEDAZD
SEhIYWHhNddcU1hYuHbt2uuvv955X19f38jIyDlz5oiIXq+/7777li5dKiIeHh4NDQ1eXl5l
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
PD1NQwe1/e5qjwC/OTdNXfz4nxVFGTZk4KhhCa2fHTZk0Mv/eL+zZS68J+VPf1tqsTZER4YP
7Nf8xc/S8grHPDcAAAAAuFzcvn3Tly9vMhpXL1zYZr6hS/ruHzdu5LffhuXlJW7duq/dTZQv
nam+/pa33jJZLOtTUvL79r2QLqUREd/efvv3N92UsH174vff+1RWiojBZotPTY3ftSu/T5+9
kyZlJySoOl2XV4tuFhMTk5OTU15ePmrUqMLCQi8vrz179vj7+4eHh2dlZYWFhR12XOR6tujo
6AMHDjhmiw0GQ1NTk4g0NTUZjUaDweBY/8xutxuNRsdTcKEBe/eO+/xzx/bhUaO2z5jh2nou
jteZM3PfeONU376bZs3q4GlVnfv3vxf16vWP//3fRrN58M6dKa+88t5vflMTEFDv7e1dWenY
y+Lt/e9f/1pEHvzDH/Q2m6OxMjj4k0ceaTnSyA0bQvPyWh7GZmSM+/zzjxctqtHCvagBAACA
i9J8o+TmeWVFUX58160/vuvWNnsZ9PpfPnpvm8bbZk2/bdb0cx14wpjhE8YM7/ApH2+vuvp6
x/eRRyYNHpnUfK+acaOTxo1OcmxPTB7h2HjqN486NoIDe7z4zG/aHGrX3kPjxwwTAAAAAHC1
2MOHb3zvPbtOt+aBB5yvUz3jvfd0qrr5lltqfrg27gL7Wry8vrnjjpnLll27cqV/WdnuKVPq
fH1bno06dsy/tPSi61dU9YZly3qUlDgWsu5U33pv711Tp6ZNmdJv376kzZsjcnNFVUVVI7Oz
I7OzqwMD902YcHDMmM7eahpuxcvLq7q62m6379mzR0TKy8sHDRpkNBpramrO1SU4OLi6utr2
w7QcXM5UV9doNts7+p5H5PHj1y9frqiqiOT16/ft7bd3e3VdwK+iYu7rr2cPGbLllls63MFk
tfqXlX115531Pj4ism/8+PFr1/bMyckcNuzEoEED9u7dPXWqXadTFaW21aerg12na/nQFpGG
Vhclh+Tnz3jvvXV3393hytsAAADAFcbQza83ZVLyhq2pUyePvcTjbN+V/odfPXL+/XAFMXT+
XkcAAABAN5jx/vu6piaLt/e4L74Y98UXrZ8qi4j4ptUkzYD0dMVu33n99S1TFBfeNysp6QtV
vX7FiuEbNw7ftKkiJKTO19dotfpUVnrV1IhIXr9+p3v1uoj6Yw8dijlypEmvtxmNE9aubf2U
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
+ugjKSq60J1XrpTp06Wy8nIWBHQ7i0XefFNEJDxc3n1Xtm1jUhkAAADARVJFVEVURURRRKfo
DIrOYBDHjZcv4P5SXl6eFov1PPt4mluWxb5v/uwNW1PjB/RtvcOtN18/f+6NbXp5e5lFpPpM
bebx3J/89llHY0VVtbWhoaKiavDAuPPW1mFfEfH2bl7c28PDaLU2iEhdncXzh++kt1xOnX3i
lIjsSj80ZuTQ874WulP2yZKf/fGD9u0/eWr5y3+Y37dXiPPuxcXFn3zyyaJFi/Ly8mJiYhyN
ZrPZw8MjJycnNja2pqbGaDS279jU1PTFF1/89Kc/veR3AAAAAODyU1V58cXOddm8WSZNknXr
hO+S4oqxYoVUV8uvfy1PPCF+fq6uBgAAAICm6aR5EWxFFJ3oDOJYB9vby7PeetaE8Xdbdo4b
lWQ2m9oeoTP3Tg4PDS6vqLrw/e12e+LgAc/8ru1MnnoBc97n6nuBYntF5uYVpB84MuvCFu5G
t9m082jVmfr27VVn6jftPHreeeWIiIiQkJAnn3wyNDR07ty5Le133333smXLLBZLSEjIPffc
077j0aNHS0pKXn75ZRG55557WuakAQAAALijrVtlz55O9zpwQMaNk6++kgEDLkNNVw5u76oV
MesOnP6f6fUhp+Tthy/TSxCfS3gHRbm6BAAAAFyF2k4KN99fWUR0iq62rt7bq/nq3o9Wf3Xt
hLZrJdXVW8wmD0+zyfLDJLS95Z49P9i+K72yuuaG6yaISEVVdUBAJ74e6+/nU1redhWywB4B
5ZVt19/2NJst1obWNXTYt0NeXmaLxeqYMt+Ztr9PTHRIUI9xo5O27NgjinQwlQ6XmjJ2YJ/o
5snjf/5nq4g8kDLB8TAmKuhCjnD77be3b4yMjHzsscdatzz//POOjbi4uLi4OBF59dVXL7Zq
AAAAAN3rpZcusmNurowfL198wXLBznF7V02o7TfGR8TH1WUAAAAAuBIoiqIoiuhUVex2EbGL
SPO88szrJ7257OPFDy8QkW2p6b2jeiqKIiK5pwqKS8tDgwOPZOX08PcTkV5REYcOH7Pb7aIo
X67f2jcmuvVLDOzX55kX3pg6KdloNHy2bmP7yWnn5YWHBG3fvW/syESbrWnT9t3XTRwzIin+
xdffnX7tOJ1Ot2vvQceefWOjd6cfGjsy8UxN7ebtuyckD++wb4evMmb40C++3TL3pqk2W9NH
q9b97+9+KiIjkxL+9vdld8ye0ckzissuJio4JirYsf3JV2kick3yea4kKDz43WUv69wy17/l
wlfvZnxRXetIUOtIUNOIT+tIUNOIT+vaJ6hvsA3O2OYR7u9xxmKsPc/NmzpQVmafOO7QfRPL
B0V0RYFXJi6XBAAAAICri07R6QyK6JpsTXa7am9q0ukNzfPKM66bkF9UfM+ix328PHuGh/50
4Y8c7ZERYe+tWHMir0BV1ccWPygivj7ek8ePevDnT3l6moYO6t/mJXoE+M25aerix/+sKMqw
IQNHDUvoVIWLH777r6+/s/zjz60NDbfNmi4iURFhyaMSH/7lH319vAb27+PYbcyIod9u3P7w
r/7o6+M1NL7/ufp2aNYNU15e+t5PH3vOrtrnz73Ry9MsImaTR2x0z+SRiZ2qFu7J7BfqwlcP
6dfxFxoAAAAAXD6FL4x3bCi2Jn1VjaHyjKG82lBxxlB5xlDReqNaV2tp313X0JTw1uaCxfOr
pozq3sIBAAAAAHBHqqo2NTUpqmq320UUnU6vUxTF+d2Lf/LbZ1/98++6rUTnDh05tvH7XY8+
MP9yHPy3f3zxz3/4+eU4MrrKT55eLiKvPnmnk3127Ds2oEcHfyfqNoUH17vw1QEAAAA4pzQ0
GirPnDXlXHFG79ioOlM259qKG8e7ukYAAAAAALpSXXn+yLv+78L3T3y79uCi0YoooupERBRF
dEadTme4XAVqyqEjx6Ijw11dBc7DoNdfyG7M7AIAAAA4F9XD2Bga2Bga6OpCAAAAAABwXzrR
qaoqoiqKTlF0oig6RWFeWZZ/8vnGrbv+/CQXK7u7xfdNdXUJAAAAAAAAAAAAwBVOURRVFRFF
p9MpOp1dFVVVz7MONqAtO/Yd88v/3NVVAAAAAAAAAAAAAG7hItbBPvyTsXa7KqIY9AZFp7M1
qTod1ysDAAAAAAAAAAAAAH6gqqo4Lk5WVbXJLna7qio6V1cFAAAAAAAAAAAAAHA7drvdbm+y
2+0iwvXKAAAAAAAAAAAAAIBmiogoikjzLZUVRURUQ1ZWlovrArpO3sncSF0PFxZQV1Howlfv
TmUVVUE9/F1dBS4eCWodCWoa8WkdCWoa8WkdCWodCWoa8WkdCWoa8WkdWQ3ukQAAIABJREFU
CWodCWoa8WkdCXaJhrrOzgj31OlERBFV7HZVVUWn6HSKYujXr99lKhHofmV1SnLiVFdXcVXI
ysri00PTSFDrSFDTiE/rSFDTiE/rSFDrSFDTiE/rSFDTiE/rSFDrSFDTiE/rSNA1ttaKiKIo
IopIk6KITqfT6XSsgw0AAAAAAAAAAAAAaKYoovvvMtii6BRVVOaVAQAAAAAAAAAAAADN9Hqd
IiJi1+lUu6rYVXtTk515ZQAAAAAAAAAAAABAM7vdLqKK2iQiIjpFZ9TphHllAAAAAAAAAAAA
AECzH+aV7aqqKorodKoI88oAAAAAAAAAAAAAgB/YRRXVLqoqqqqqdtXWqKrcXxlu73RptcXa
2KbRbDKGBftdSPfGxsa33nqrqKgoLi5uwYIFLe379u178803DQZDRETEb37zG0fj559/7uPj
M3ny5E2bNmVlZf34xz/uqncBAAAAAAAAAAAAaIWiKIooqoiIqKrKvDI04Jkla9Mz8to0JsVH
v/rknRfSPTU1NSQk5JFHHvnLX/6Sn58fGRnpaK+trU1JSZk8eXL7LlVVVd98881vf/vbS6wc
AAAAAAAAAAAA0BxFUURERKeIqoqIapfW62D/a/mnG7ament5RkaELn5oga+Pt4jcu+hxg0Ev
Iqoqw4YMfPje2w0G/Qcrv4jqGTYxeYSj48bvdxWeLpk/90YR+eljz1VWVTva590y7ZYZ1154
fX/8698f+NGtkRGhTz2/5NEH5ocEB3bBm4b2PZAy8SdPL2/feIHdIyIi+vbtKyKBgYEWi6Wl
vba21t/fv8Muy5cvnzNnjo+Pz0XVCwAAAAAAAAAAAGibIoooioiqiKit55W/XL+1oqJq2ZJn
FUXZtG33a2998NjiH4uIyeTxjxeedOyz9N3/rPz829tmTXfyAkajYdnrz114QV9v2FZnscy+
YYqILH7obj9f74t7Y9Cct9/7YPrUa3tGhJ93z6T46Ats7FCfPn1EpKGhIT8/PyYmpqW9pqZm
06ZNn3766Z133jlkyJCW9rS0tJqamhEjRlzg8QEAAAAAAAAAAIArjF1VFVVteagoonNsff71
pofvu91xRfPkcSOP5+aprfZzuGf+rM3bdp/nFdr1unBMKl89Pl3z+eNP/mnL99u77RXXrFkz
adIkvV7f0jJ27NhFixYtWrTok08+ab1nUVGRTqfLycnpttoAAAAAAAAAAAAA96GqdlW12x33
VRZVUVRF+eH+yqqqent5tuw6f+6NVmuD2Wxq3d/k4WFrajrPizSvtd2BN9/7eGTS4GFDBonI
G+98NG50UkFR8fKPP7fb7ZWV1ffOn33e5a8bGhr/77V/lZSWN9psd827edzopLfe/2TYkIEj
EgeLyPrNOyoqq+fdMm3FqnXr1m/18faaNG5EcUn5ow/MP/+5QTdK3b3n5//z+wfvX3D7vDnd
84rHjh07efLkvHnzWjf6+/t7enqK/P/27jw+quru4/jv3JlkliSsQshCQCXIJriwC1pFxbII
FhWsLIKALSjiYx8VsBas9dHWhVZtXShatFLR1qrPwyKIoBQFEZRNICD7voQEspLc8/xxJ5NJ
CFsyyeQkn/crTe7cOXPm3PuN9AW/OedIQUFB6PlbbrklKSlpzpw5jz76aNUMDwAAAAAAAAAA
AKg+bNt2DrSIpcRlaRGxRCQrO8friQ5tekPPLqWKyiKSm5vnDpnuebqs7Jwjx45PnPLsvQ8+
8fH8z885oFtu6DH0jv63D+h9z10Dz+cC3v94QecrL//j05P++LtJ73zwiYh07dhhxbfrnGdX
rl7ftVOHPfsPfr3q+xnTp730zOS9+w+dT7eoVGu+Xzds1Ljs7Bzn4fYdO0feN+En117zm8n/
XTUDyM/Pf++990aMGOE81FqfOHFCRN5+++1du3adOHEiOrrEL7/L5brsssu8Xu+3335bNSME
AAAAAAAAAAAAqiFnuevCwoLCwgJLRLTWZ5ln7LBt+7VZ7193Tcez93tDj87P/Hriy89O/uzL
FRs3bwvjoEXkp7163tCzi4hERbl9Xu+pgoI2l126eWtgveIDhw4nJ8R/t/aHm6+/xlnu+Kbr
uoV3ALhQGzZu+vk993225IsRY8bn5ualpx8fOmpcclLin6f/3rKs8+xk+54j53myTCtXrjx8
+PDLL788bdq0hQsX7t69+5133hGRvn37zpo167nnnhs4sIyPNQwaNOjDDz8sPOcEfQAAAAAA
AAAAAKCm0cEvbdt2YaFdWOgWp858hn2R8/Ly73t4mohYltX16vaD+t10lu79Pu+IIQOc45F3
Dfx82co2l10axuHXqxs356MFP2z5UYls3b5L29pyq4sa1j9yLD3zRNalzVNE5NjxzFapF4fx
TVFum9O2Dh42JiE+/ulpUx565Ncj73sgNzcvNzf3X7Pf9Icsun5223YdfvDJ2aeff2Dqu398
4q5LUxqds4cePXr06NEj9Mwvf/lLEUlKSnr88cdLNe7bt69zkJyc/NRTT53nIAEAAACggpZv
2f3lDzsfHdDj3E2LaJE/zf3607U/zn5wUB2f54X//erDlZtclrqtc6sH+3T9cOWmv3+5NqF+
7B+G3eyNclfeyAEAAAAANZF2ysdai9iFYheIiFtEYvy+nLy80IaLv1zRvdMVXq/H44l+7fnf
lOrGsqzQMrTW+vS5p00aX3QsPSO8w3/v3/Mty5r26HgRefiJPzgnu3XssHL1uswTWV07dXAG
o89QI0dV+nH7jsFDR9evX/e9d2Y0uqhhjN8/ZtxD0dHRH73/dnx84/PvZ+mKzRknck4/n3Ei
Z+mKzedTVwYAAACAGmnBd1u3Hzr+0SND3JYlIhnZubPuH3hx4/oiUmjrd5et+/uDg/762epF
637sd1XLSA8WAAAAAGASbdvFJVdtK6211oHPLFvKysrOiSmaRTrnowXX9+h8po4a1q97+Oix
4MPDR9MvalhfRL765rvjmSd/2quHiKRnZNarVyf0VT6vNzcv3zkObvV8Qb5Zs/7ZJ/4rMP6i
K+lydfsXX52Vm5vvzKVu2KDeseOZ5egcYbRr99477r7X5/O+/87MRhc1FJGbb7z+5enP+v2+
Nq0vu6CubujW6pKmgeLxX99fJiL33hH4/H7z5IZhHTUAAAAAVK4psxcP7t62bdPGd7ww51+/
GvzqwlUL126L83r+PDqwctL+9BO//ecXfx7d991l60RkcPd2T7z3+baDx9okN3ri9uv+tvQ7
T5R7SPd2TuPF67ePvP4Kd9HnvDOy82K90c7xocyshHqxHrerfbP4b7btrfILBQAAAACYzbYL
JDiTV9uibdE68PfPvjdd+8asD5zj5Su/a5acqM684/JV7dssXPLViZNZInLiZNbiL1dcdXlr
EWmVesmiJctPnSoQkU/mL+l6dfvQV116cdNV321wXvLFV6uck36/98SJk+d5AXViY3bv3S8i
Gzdv27h5W0FhoYjExcZkZedERbmjotwicnWHNouWfuXUrb/8evV59ozw+n7derfb/f7fZzZp
Ujw1uX+f3r1+cu2FdtU8+aKfdL3M+apXx1evji/4sHnyRWEdNQAAAKqvArvwlF0Q6VEAFdW5
ReL3Ow9u2X+0XdPGBbYtWv758ODLU85Y+v3yh53NG9f7x8TbM7Lzth1Mv6Nr2wEdiz+qu/fY
ib9/uW7wi+9/v+OAiBzPyh03Y+7df/rnvvQTJ3PyvNFuEfFFR2Vk55XZOQAAAAAAZ2QXiC4Q
XSjaFl2odaHWhYH5yrf06rH3wKER90+J9fsSmzSeMPbus/TToH7de4YMfOzJF7VoS1mjhw6q
X6+OiNSvV+e2fjdOnPKMUurKy1t1urJd6Ku6XN1+0ZKvfvGrJ+Ni/e3bBNbgurJdq1n/+Djz
RNb4e+865/iHD7712Zdmul2uNpdd2ufGa9OPZ/p9XhFp1zo1LjbGaZMQ36h7pyvGPDQ1Ntbf
vk3LwsLCC79PqKj+fXrfeP11Pp830gMBAACA8fZnHfvbhoVpx/aISMsGTYe3vTEhpkGkBwWU
U5fU5D98vDzKbXVOTXJbVouEBhNmztubntkupVGU23V6+x8Ppn/8zabP12/PystPP5lzaXz9
0Gdz8k8N6tK6QazvmY/+89df3DqhT5cWTRp8+v22tz7/7vZubYLNrDN/ahyV65VXZPz4SA8C
AAAAAOStdQvuubx3hbrQWoLrYCulRg8dNHrooFJtTt9c2dG1Y/uuHduffr5Hl6t6dLmqzJdY
Sv36V78odTImxv/6i1Od46mPjg89ePK5vxw+kh5sOWHs0NRLUsocz7A7+oc+HNT/pkH9bxKR
1d9vXLtxS5mDQWWjqAwAAICKyys89fyqD/J1Yc9LO4jI6n1pz6/64Hc9RnpcUZEeGlAeTerF
pmflrNt5aEKfLpk5eW9+vmbmuIF/XRyy1FbJGnCh1mNuvPrWjmVvJxTjiWrfrIkv2p2RlSsi
LRMaxnqjr2mV8vmGHXV8npz8UyKSk38qzhddiZeEM5k+XWbOpK4MAAAAwFi6aB1sLUXbE7sj
N5pzeOJXvyzHq2zbnr94WZ8brxWR/6xc0/mqy8M9LkSM21XG5/cBAABQgy3dtTbnVH63iwMr
IXVObj1n7ZLecyZVqNNVYRgYIsm0BP858InQh00bxW3ee9QdXbjzWIYnynUi/2TagSON63nF
KswrOFWo8vcfP3EkJ3PLgcPJDePq1/EuT9t5TduE73ccatv0olOFtlLijQr8Rb5FYv0lm7Y2
a1Q31hd1NCfzvr/M+9Pom1fvONAgzuOKLtybnrkvM33Ftl3JDesczckMDuDxL9/64eiuKr0F
pZiWYDn0X7z24RkLv7rykkmzfxXpsYRbLYivhiNBoxGf6UjQdCRoNOIzHQmGw4XPV7aLDpQq
Oq6+deXysSzrxMnsX/zqSZdltW3VosvVZUyqhqEmjrwx0kMAIuytdQveWr8wbN3xf8amI0Gj
EZ/pSLCqNPDFNYipG3omPraeiJ2Zmx2pIQEVdPUlTZyFqRMaxPo9UcOmf9IyqUFWXmBWsS/a
3S6l0Yg/ftIg1pvcMK5n66ZL1+8a/crcxAaxLRO7f/JNWrTbNbBLYGOpIT3bPDVnWVbeqQf7
dRKRIT3ajH99gS/aPfn27pZSg7q1Gvfa/Cb1Yu/q2bbiw74qqeVVSS0r3k9tcPFHC6/56yIR
adC2/ejO/SI9HAAAAACQ1XsvfIFnZ46yViJaa3EW11K6aOYyUAN8/f3Wxza+GulRAJWIf9ED
ANQqW4/u/fHovptbdgqembN2SWbuyQgOCbhQpeYrR1z55itTHz1PKfO/6DlhqrK1iKx55L4N
Y4dEekQAAAAAIKv3bnnh2rHn377Dm1lrR18sIuIUlLVWUqhq3nxlgH/vAAAAqDGa12+y6/jB
lXt+uCoxVURW701rFFPnZ+16ui12SIEx/NHeSA+hhFvb9LgmL/Pc7XDhkpas6DHxt05RWURO
JsVHdjwAAAAAUH7aWftaiVKiAlssU1cGAAAAUE25LVen5FbrD26fv3mliDSMqdMxuRVFZQDV
UJOv1lw77tdWQUHwTBZ1ZQAAAACmUyr0EXVlAAAAANVXnMffLaVtobZFi8uyIj0cAChDo9Ub
fjJ2siv/VOjJrETqygAAAACMpUVU8Lt2/kddGQAAAEB151KWqHM3A4Cq12BD2g2jHnHn5Iae
tKPcuRfVj9SQAAAAAKCClCittYgWLSJaiy1K3GlpaZEeGBA2u3ft7NKqWaRHAQAAAAABe37c
GekhlNBC4lpIXKRHUXNEb9mSPOIR18nsUucLExI7S1OxIzIoAAAAACihS0LSBVaEE0VEhXzG
X4uIiFsry7ZtrUVrp9xc/L2UMk8C1cqpAjs3v+Dc7VBhu3btSklJifQoUH4kaDoSNBrxmY4E
jUZ8piNB09WwBD07dyaNGOE6fvz0p/ISEmreX05rWHy1EAkajfhMR4KmI0GjEZ/pSLB8lCq9
7FtWVpZzMviUUmJZlhJlWZaylGVZlrIsS7lcLildVFbORstul+WylKUdgWJzqRKyKuskUB25
XC63m9Xdq4Lb7eZWG40ETUeCRiM+05Gg0YjPdCRoupqUYNS+vc1Gj3IfPVrms4WJSTXmSoNq
Uny1EwkajfhMR4KmI0GjEZ/pSLB8QurKgfKuy2UVV5RFBYmSYEXZsizLssrsTYslot0ut8u2
bXHKxlrkzPVj6sqo/lwul9vlivQoagWXZXGrjUaCpiNBoxGf6UjQaMRnOhI0XY1J0H3oYPI9
I6L27z9Tg8Lk5JpxpaFqTHy1FgkajfhMR4KmI0GjEZ/pSLB8Tp+v7Ha5i8+rwIEzX1kpZVnO
d8s5WaqTQAlZKbfLsixliUhgxrISoYQMY7ncLncUn1upCtxq05Gg6UjQaMRnOhI0GvGZjgRN
VzMSdB07mjBieNSuXWdpY6c0rQFXWkrNiK82I0GjEZ/pSNB0JGg04jMdCYaLy+0K1Il1YLay
iCglTjk5uER26JTlYL1YKxFRIsrtdrsDFeXQp6krw0wui/nKVcTN1HDDkaDpSNBoxGc6EjQa
8ZmOBE1XAxK0MjIaDxsWtXXr2ZvppimmX+npakB8tRwJGo34TEeCpiNBoxGf6UgwXNwuV8jO
yoEqslJKOxVjpYqKyip0Z+UArZRyaRG3U3MumqwcmK1clZcBhBH7K1cZbrXpSNB0JGg04jMd
CRqN+ExHgqYzPUF18mTD4cOiNmw4d9OUFKOvtEymxwcSNBrxmY4ETUeCRiM+05FguDi3MTjD
ODhl2QrZajmwLHZZWyyLiDrTfOVQzF2GQdQZdhRH2J1p83aYggRNR4JGIz7TkaDRiM90JGg6
oxNUOTn1RgyPWr36fBrrpk3NvdIzMTo+CAkajvhMR4KmI0GjEZ/pSLCCgnOUQ29jcL7yp59+
2rt3b6WcDZeVUk5ZWUmwAi2ByctaRLS4XZblbKt82iLYp81xBqo9N59bqSp8RMh0JGg6EjQa
8ZmOBI1GfKYjQdOZm6DKy4sbNTJq+fLzaWzHx7v8/soeUtUzNz44SNBoxGc6EjQdCRqN+ExH
guHiclkSUmZWSs2fN1+JfLpgQZ8+fULKyoF5zKWrxVpEibuo6KxD68jMUYahLGW5+NxKlXBZ
3GqzkaDpSNBoxGc6EjQa8ZmOBE1nboKuPbtVfv55Nrabphh6mWdnbnxwkKDRiM90JGg6EjQa
8ZmOBMPFZRXvrywi8+bNC653PX/B/D59+oRWlkVEVMic5SJupzqttX77/U++/Opbv9+XGN/o
lyMHx8ac/tHa85rB/O95ny1c+rWI3DN4YKcr25bnyoDyUi7LYv/2KqEsbrXZSNB0JGg04jMd
CRqN+ExHgqYzN0HdqnX23Hmub77xPP+ce+7cczROaWroZZ6dufHBQYJGIz7TkaDpSNBoxGc6
Eiyv0jVhy2UF68pz585VlgotM8+fN79v375FZ4KvdVa/luDsZLelLBH5dOlXmRkn33hxmlJq
2YrVM97+18PjR5RjjLt27/t+/ea//P7xnNy8R5984cr2l3mio8vRD1A+LstyPiqByuZycavN
RoKmI0GjEZ/pSNBoxGc6EjSd8Ql27ZL3/vunNm6Meu459wcfSGFh2c1SUsy+zDMwPr5ajwSN
RnymI0HTkaDRiM90JBgurpDyfP9+/YPHIdVlHZiorIpvuC7+qUTEbVlKRC1YvOypyRPcLrfW
+tquHd/7cH7xNOcL8fWqdf17X++yXLF+f5er2q/fuLXTle0u+MqA8lJKWYo/X6qCEm612UjQ
dCRoNOIzHQkajfhMR4KmqyEJtm136s23pEUL9+9+V3aDZs1qwmWepobEV4uRoNGIz3QkaDoS
NBrxmY4Ew+UMt1EHq8FOOfns1WG3FVg7W8fF+kXE2Vh58MBbTp065fV6Jj/1x8SExj9s3uZ2
ux6ZcG9Sk8ar125c98PWEYNvFZFv1qzbvHXH0DuKa9p7Dxy8rkdHZ8vmpolN9h845BwDVcNS
il+5qmFZ3GqzkaDpSNBoxGc6EjQa8ZmOBE1XcxLMzXXNnOkc2jfeaK1YISdOFD+bklJDLrOk
mhNfbUWCRiM+05Gg6UjQaMRnOhIMl5D6cej9VCXOnGPKsXYry8rKzvF6PM5rnO839OziPP9D
2o/jRg2ZMObujZu3vfbW+09NfkApSynlVKOVspSyrJDtsnPz8uvExjhn4uJiDh05arGZNqqQ
six+5aqGxa02HAmajgSNRnymI0GjEZ/pSNB0NSZB68031f79IqKTkwv//e/C7Gzr1VddL70k
hw+LiGrevGZcZik1Jr5aiwSNRnymI0HTkaDRiM90JBguZdzGklXk4upy6a2Zg2eVO9DIspRl
aV264cXNklOaJopIm1YtjmdmilLFX877BY9FRMTWOnjGsixbn7OyDYRVyV9IVCJutelI0HQk
aDTiMx0JGo34TEeCpqsZCebmWn/4g3NoP/aYeDzi8diTJtkPPmi99Zb1/PO6WbOacJmnqxnx
1WYkaDTiMx0Jmo4EjUZ8piPBcAm5jWUsdq1FSXDWctmFZRFxO+uSK62DGyqXqC5rFezF7/Pn
5eYrUaqoayWqxNuIWMrSdtEZrSzLCn0WqGzOJx0iPYpagVttOhI0HQkajfhMR4JGIz7TkaDp
akaC1owZat8+EZGUFD1yVPEV+WP0uPGFY8aqqKgIDq/y1Iz4ajMSNBrxmY4ETUeCRiM+05Fg
uDi3ce3atWU9WVwavuKKK6S4wOwUfLVTdhbRbqUkNsaXk5cbfI1S8vmyld06dvB6PUqFbtes
laWUCmQoZUxXFq83Ois7u0H9OiJyIutkjN/LZwhQlUJ/Y1HJuNWmI0HTkaDRiM90JGg04jMd
CZrO/ARDJys/+qjyRJduEF0zi8oiUhPiq+1I0GjEZzoSNB0JGo34TEeC4VF0G884F/lcbBFx
O4eWcmXn5Mb4fc7D9z/+9PoenZ0acnAqdHZOns/r8Xk9efn5zknbtpVSoXOlU5ITduzel5Kc
ICK79x64vHVqGTOpgUqk+JWrGqX+24dxSNB0JGg04jMdCRqN+ExHgqarAQmqGTOkaLKyjBpl
+uVckBoQXy1HgkYjPtORoOlI0GjEZzoSDJfzuY3nuNtKLKdF35uunfH2P53jr775vllyomVZ
Sqlde/cfOnJMRDalba9ft46IpCQnbPhhq23bttbzF/+nVIfXdL7yo3mLba2zsnO++ub79m0v
q9AlAgAAAAAAVBO5uer3v3cO9WOPSfRpk5UBAAAAoDpRF+LM3WjnKzBf+ZZePfYeOHTPA4/H
+r0J8Y0njL3bOZ+U0PidOZ/s3LNPa/3Yg2OUUnXiYq+7ptN9Dz/p80Vf3qqllKxvX9IsuXun
K8ZM/I1SMnroIJ/XU3k3Ajgdn1upMtxq05Gg6UjQaMRnOhI0GvGZjgRNZ3yCb7xRaycrSw2I
r9YjQaMRn+lI0HQkaDTiMx0JVhtagutgK6VGDx00euigUk3cLtfD4+8pdfLOAb3vHND7TL3e
fuvNt996czjHCQAAAAAAEFlMVgYAAABQCziFfKWU1iU3Y9ZF85UBAAAAAABwRq+/HjpZOdKj
AQAAAIDwCJ0RXnysC5WIFqe0bIvYorX7XJPHmV0Ok7AeQpXhVpuOBE1HgkYjPtORoNGIz3Qk
aDqDE8zNlaLJyjJpkvLUxm2/DI4PIkKChiM+05Gg6UjQaMRnOhIMl+As5PN+RYGIViKiRMTW
2pbgOthn8tIzkyswQgAAAAAAAPO99hqTlQEAAADUIs4i2EoHD+WcdWUAAAAAAIBareRkZXZW
BgAAAFAL6MA35fzQQl0ZAAAAAADgbJisDAAAAKC2o64MAAAAAABwdu++GziYPJnJygAAAABq
Ay06eBRkRWQoAAAAAAAAZvjiC3nlFeneXUaOjPRQAAAAAKBq6NO/qCsDAAAAAACcmccj48bJ
f/7DZGUAAAAAtUZoRdl2DtxpaWmRHhYQNrt37Wzo1+duhwrbsWNHpIeACiFB05Gg0YjPdCRo
NOIzHQmajgSNRnymI0GjEZ/pSNB0JGg04jMdCYZLfHx8RbtQ4k5NTQ3HYIBq4Wi2Sk1tEelR
1Bb86WE6EjQdCRqN+ExHgkYjPtORoOlI0GjEZzoSNBrxmY4ETUeCRiM+05FgWGRmZla8E9bB
BgAAAAAAAAAAAACcDXVlAAAAAAAAAAAAAMDZUFcGAAAAAAAAAAAAAJRJiYho6soAAAAAAAAA
AAAAgLIpEUtEUVcGAAAAAAAAAAAAAJRJi4iIckd4GAAAAAAAAAAAAACAako5P6grAwAAAAAA
AAAAAABKUaEH1JUBAAAAAAAAAAAAAKcLlpZD6soz3/3w82UrY/y+pITGE+8bFhcbU+7u9+4/
tGXbjut7dK7QIAEAAAAAAAAAAAAAEaBCji0VrCvP+2xZenrGrFeeVkotXb7q5RmzJ00cXY7u
Dx4++upbc45nZNaNi6WuDAAAAAAAAAAAAACmUSWPXSJiOY/+79Olvxg5WCklItd17/jjzt1a
63K8Q05O7vDBt06eOKbigwUAAAAAAAAAAAAAVDklopSylEOUiArMV9Zax/h9wYZ3/axPXl6+
1+t5ZOrzSYnxGzZtdbtdkx8am5wQv+q7DWs3bhn189tEZMW3azelbR8xZEDwhc1TkkTk8JFj
VXthAAAAAAAAAAAAAIAwcGYjK1GiRLQlSokzXzkrO8friQ5tekPPLl6vR0Q2bN468Kc3vP7C
1PGj7nplxuxIDBsAAAAAAAAAAAAAUHWcOcpFX5aI5RYRrbVTZD7dJc2aNmuaKCJtW7U4npFZ
pYMFAAAAAAAAAAAAAFQtpZSIs/y1iFKilYi4A0+cx27Kfr8vNzevkgcJAAAAAAAAAAAAAIgY
rVxKlBYlIkpbIpYzZ1li/L6cvBIF48Vfrii7hHyGac0AAAAAAADdO+ebAAAMG0lEQVQAAAAA
gBpAK4+tPLaKtiXaFreIS8RlOc9ZysrKzgk2nfPRAk/JHZdFJDsn1+uJ9nk9uUVFaNu2q2bo
AAAAAAAAYZaVJVOnStu24vdLgwbStau8/nqJBunpMmWKtGsnsbHSuLF07y6zZklhYel+3n5b
OnYUv18aNpTbb5ctW6rsCgAAAACg8jkTj1Wgrtz3pmvfmPWBc7x85XfNkhOVUiKyc8++Q0eO
icimtO3169YRkZTkhA0/bLVt29Z63mfLIjF0AAAAAACAitm/Xzp2lGnT5NQp6d9fevaUjAyZ
Pbu4QXq6XH21PP20+P0ycqT06ydbtsiIETJmTIl+nnpKhg+Xgwfl3nvlppvk44+lSxfZtKmK
rwYAAAAAwk+roqKyiGi38/OWXj32Hjg04v4psX5fYpPGE8be7ZxPSoh/+72Pd+zep7WeNHGM
iMTFxlx3TacxD031+TztW7eMwAUAAAAAAABUhNby85/L5s3y+usl6sTp6cXHb7wh27fL2LHy
2muBM4cPS4cO8uab8uSTkpwsIpKWJtOmyaWXyqpVUq+eiMi//y233SYPPCALF1bZ1QAAAABA
+GkpLiorLVoCdWWl1Oihg0YPHVSqvdvlenj8PaVO3jmg950Dep/lXRpd1GDqo+PDMV4AAAAA
AIBwW7RIliyR0aNLTz6uX7/4+McfRUT69Ss+06iRdOsm//qXHD0aqCv/7W9SUCCTJgWKyiIy
cKB06yaLFsmOHdK8eaVeBAAAAABUPuUUlUWJFemhAAAAAAAAVK0PPhARGTVKNm+W55+XadNk
9mzJyirRpm1bEZG5c4vPHD0qX38tiYnSqlXgzNKlIiI33VTihTffLCLyxReVNHYAAAAAqHTa
+aGKvmsdXAcbAAAAAACgtvj2WxGRL76QKVOksDBwskkT+egj6dw58PDee2XWLHn1VVmzRjp3
lqws+eQTqVdP/v538XgCbdLSJDpamjYt0XlqqojI1q1VcSEAAAAAUCmKdlZWSkTbSpQ+13zl
l56ZXBUDAwAAAAAAqDJHjohSMnmyPPKI7NkjBw7IU0/JoUNy662SmRlo4/fLkiVy552yYoW8
9JLMnCknT8pdd0m7dsX9ZGZKXJwoVaLzOnVERDIyqupiAAAAAKCyKKWCk5ZZBxsAAAAAANQy
ti1aS79+8vTTkpQk8fEyZYoMGyYHD8o//hFoc+SI9OolK1fK3LmSmSl79siUKfLb38rNN4tt
B9poXbqoDAAAAAA1QXAFbKewrLVo6soAAAAAAKCWqVtXRKRfvxIn+/cXEVm9OvBwyhRZsULe
eUd++lOJi5OkJJkyRe69V5Ytkw8/LO4nM1O0LtGPM+PZeQsAAAAAMJFWoq3AathKaSVamK8M
AAAAAABqm5YtRU4r/darJyKSkxN4uHChREVJt24l2lx7rYjImjWBh6mpkp8vu3eXaJOWJiLS
okWYxwwAAAAAVUZrkZKfoGUdbAAAAAAAUOv85CciIhs3lji5YYOISPPmgYf5+XLqlBw/XqLN
oUMiIh5P4OF114mILFpUos3ChSJFFWgAAAAAMFHIjj9aO8tgsw42AAAAAACobYYMkbg4+fOf
i6caHzwozz8vIvKznwXOdO8uIvKb3xQvc33okPzpTyJFZWkRGTFC3G555hnJyAic+fhjWb5c
evUqrk8DAAAAgHGUCikta+evRe40Z3UmoEbYvWtnQ78+dztU2I4dOyI9BFQICZqOBI1GfKYj
QaMRn+lI0HTVKsE6jz8e/+ij9uWXn7z+enG5YpYscR09mn7ffUf8fmch6+iRI5vOm2e9/HLe
Z5/lXnWVlZUV8/nnVkbGib59DzRpIkX/nNLg/vsbTp9e0Lr1yV69XOnpsQsW6Li43f/93/k1
7t9bqlV8KAcSNBrxmY4ETUeCRiM+05FguMTHx1/4i4KlZSWWpUTcqampYR4XEDlHs1VqKltY
VRH+9DAdCZqOBI1GfKYjQaMRn+lI0HTVKMFHHpEOHaz/+Z86ixZJYaG0aycvvFB/+PD6wQap
qbJmjfzud57PPvPMmSNRUdKmjYwYETduXJwVsvzbiy/KlVe6p0+v98EH4vPJrbeqp59udtll
EbiiyleN4kO5kKDRiM90JGg6EjQa8ZmOBMMiMzPzwl6gpGh/ZS1KlLKUiDv84wIAAAAAAKj+
eveW3r3P1qBFC3nzzXP3M3y4DB8erkEBAAAAQOQpLVpEbBGllIjlEtHUlQEAAAAAAAAAAAAA
IZRSokIfWWdpDAAAcJ72/te4gkMHIz0KAAAAAAAAAEBFKWdvZSUiorWIFq2FujIAAAAAAAAA
AAAAIEiHHGpti9jsrwwAAAAAAAAAAAAACOEsga2dCrO2RRR1ZQAAAAAAAAAAAABACTowa1mL
KK2ZrwwAAAAAAAAAAAAAKKJUYGvlotKyJUJdGQAAAAAAAAAAAABQRGsdPBJRTpm5uK48890P
P1+2MsbvS0poPPG+YXGxMeV7jzfe/ufajZsLCwpHDBnYtWP7cIwcAAAAAAAAAAAAAFAl7EKl
lIillFNgtiVYV5732bL09IxZrzytlFq6fNXLM2ZPmji6HG+xaOnXWtsvPzMlKzvnoSnPtm/b
0u/zhu0CAAAAAAAAAAAAAACVSRXmK2VZlsuyLC1i60KtteU893+fLv3FyMHOFObrunf8cefu
4tnNF2Lp8m/uGNBbRGL8visub7V9554wXgAAAAAAAAAAAAAAoFJprUV04EBrp3DsDj4X4/cF
m971sz55efler+eRqc8nJcZv2LTV7XZNfmhsckL8qu82rN24ZdTPbxORFd+u3ZS2fcSQAcEX
3n17vwb16gb7dLlcVXZ5AAAAAAAAAAAAAICKcwrKIlL0UywRycrO8XqiQ9vd0LOL1+sRkQ2b
tw786Q2vvzB1/Ki7Xpkx+5xv0LrlJUXvpDelbU+9JCXclwAAAAAAAAAAAAAAqFTatm3btrVt
a21rbbvFmb+sVJnNL2nWtFnTRBFp26rF8YzM83+f+Yv/061TB+YrAwAAAAAAAAAAAIBZnAKy
Dq6I7cxXVkrJeeym7Pf7cnPzzudtjh3P+N8FS5yNlgEAAAAAAAAAAAAA5tAiWmvb2V/Z+bJE
JMbvy8krUTBe/OWKskvIZ5jWXMoLf5l1/+ifR7nd4Rg0AAAAAAAAAAAAAKDKaBG71JflPGMp
Kys7J9hwzkcLPCV3XBaR7Jxcryfa5/XkFhWhbds+/U3mL17WLDkhuNEyAAAAAAAAAAAAAMAo
KvRIOetgi0jfm659Y9YHzvHyld81S05USonIzj37Dh05JiKb0rbXr1tHRFKSEzb8sNW2bVvr
eZ8tK9X94aPp//fpFyPvuq0KLgUAAAAAAAAAAAAAUDmc0rKzw7IOLFV9S68eew8cGnH/lFi/
L7FJ4wlj73bOJyXEv/3exzt279NaT5o4RkTiYmOuu6bTmIem+nye9q1blur7H/+ae+TY8Yce
f9Z52L5tyzHDbq+SqwIAAAAAAAAAAAAAhJ0WkUBdWSk1euig0UMHlWridrkeHn9PqZN3Duh9
54DeZXb5wJi7Hxhzd5jHCQAAAAAAAAAAAACoKkqJM19Za+0cuSM8IgAAAAAAAAAAAABANaK1
FlFatHYeCnVlAAAAAAAAAAAAAECQdvZUDhSVA9ssW2d/zUvPTK7kUQEAAAAAAAAAAAAAqhsd
+oD5ygAAAAAAAAAAAACA0wVLy+oc85UBAAAAAAAAAAAAALUcdWUAAAAAAAAAAAAAwNmwDjYA
AAiDpBf+HOkhAAAAAAAAAADCQpd8qIS6MgAAAAAAAAAAAAAgRFl15bS0tIiMBagMu3ftbOjX
526HCtuxY0ekh4AKIUHTkaDRiM90JGg04jMdCZqOBI1GfKYjQaMRn+lI0HQkaDTiMx0Jhkt8
fHzFO3GnpqZWvBegmjiarVJTW0R6FLUFf3qYjgRNR4JGIz7TkaDRiM90JGg6EjQa8ZmOBI1G
fKYjQdORoNGIz3QkGBaZmZkVeLUSUVrECttwAAAAAAAAAAAAAAA1i7NWMHVlAAAAAAAAAAAA
AMBZKOrKAGqs9evXT58+/dtvvw09OX/+/CVLlkRoRAAAAAAAAAAAAIZRokTEHelhAAAAAAAA
AAAAAACqDxV67Dz4f4W48zrMAMS4AAAAAElFTkSuQmCC

--shmrmzvrjnjefmku--

