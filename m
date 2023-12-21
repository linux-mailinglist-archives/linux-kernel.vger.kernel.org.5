Return-Path: <linux-kernel+bounces-8642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5A481BA8F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB6D11F24F6E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E6158221;
	Thu, 21 Dec 2023 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf.com header.i=@semihalf.com header.b="gNjxjDqA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCEF539FE
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=semihalf.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semihalf.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55361b7f38eso1144460a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 07:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1703172121; x=1703776921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnsylp5tiu4gF3bIpxE6ccfVNKMtfj6MRI68DwIWxls=;
        b=gNjxjDqA8I6ZgSuReRK7fX0T6fYwFWfCNgPA11RGjwTKfOsGdDmGL9pk7xE43byfBw
         oMZjgUc0SXa3W1BpsyPjBeD8rULwc1KWeE1RNRR3+xZW7DFLXaGgXwZ3y1bJViDWR//O
         0SlckD7+X1uGJk1NM+JOrBaLWQxR1XVsP/UX/EH2DRoarVrtiYlbMDZusvqb6EiW/I8S
         KXntW3r/ulCgvkY5heyeiTB+LP3nGvVrQ6YWSe6XQuLl82uLpK0EjnEj24jabcY51po8
         DtCYV6UCB8lz/VqCxBCUGCD4bQm5nYCvJvLojeJQJ7gnr0NSmEslLvJiWdW92/VDCbcP
         MP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703172121; x=1703776921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnsylp5tiu4gF3bIpxE6ccfVNKMtfj6MRI68DwIWxls=;
        b=vY3Q2V1SRh4AkG74ATIbwiwIFAdZJ+bMcuRE6sZ3dqIASK6W1FcfLyN5DXzHGo8HdO
         SadDN4Lz/goHkbpZqY85+jrb/KVN/ycbt+FqQl3qR050ztvRVmE9PemYSP9MlnfOsHWl
         o6sUdbedFa2MIOlgpgVLAU2CeeG2PuVlezSOZyVcX+aF438YYZazxvNpGd0YmyWKQLlm
         grmJMUyIFc4NGIr2/aunx9s5pqerhzXFPGeL+7rpxDY3qlEZvzRyHm/sqQGA0ExipQBu
         6c6L6fI6iUh0TFAIzMAUUNw25W+0HqIWUrRCuHlReiy6tuQupZsvHhXGTxzIBGpLwx1v
         hDgA==
X-Gm-Message-State: AOJu0YyDkOcK3aQp1jlgtBQWhayBbBCrU7+f2Ol3xu77VPtxVfMjSV63
	wAZp/skak3eJOVCg9V2OnpGs0/IRmkRvKOrILwj5
X-Google-Smtp-Source: AGHT+IGXhFH1rShOVMnfne+Wjc4IozhQ3YJLXDXTwspOiUbojv+qLpbwdeJLCOKs1aN9JHCeS7gpp3/AeKCq0p36CM4=
X-Received: by 2002:a50:85c4:0:b0:551:7f8d:9708 with SMTP id
 q4-20020a5085c4000000b005517f8d9708mr5436281edh.1.1703172120720; Thu, 21 Dec
 2023 07:22:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8ByeK8dGcbxfXghw6=LrhSWLmO0a4XuB8C0nsUc812aoU0Pw@mail.gmail.com>
 <cover.1701993656.git.jim.cromie@gmail.com> <7cb5c8b6c6efba7e437595266638be39f23361fc.1701993656.git.jim.cromie@gmail.com>
 <ZYCBlI56kmDMew6U@alley>
In-Reply-To: <ZYCBlI56kmDMew6U@alley>
From: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date: Thu, 21 Dec 2023 16:21:49 +0100
Message-ID: <CAK8ByeJHAPijVWbATUxXpXHa7uCn3dwLgi_6ckfWY0ADmBwqcQ@mail.gmail.com>
Subject: Re: [re: PATCH v2 00/15 - 05/11] dyndbg: change +T:name_terminator to dot
To: Petr Mladek <pmladek@suse.com>
Cc: Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, bleung@google.com, contact@emersion.fr, 
	daniel@ffwll.ch, dianders@chromium.org, groeck@google.com, jbaron@akamai.com, 
	john.ogness@linutronix.de, keescook@chromium.org, ppaalanen@gmail.com, 
	rostedt@goodmis.org, seanpaul@chromium.org, sergey.senozhatsky@gmail.com, 
	upstream@semihalf.com, vincent.whitchurch@axis.com, yanivt@google.com, 
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

pon., 18 gru 2023 o 18:29 Petr Mladek <pmladek@suse.com> napisa=C5=82(a):
>
> On Thu 2023-12-07 17:15:08, Jim Cromie wrote:
> > This replaces ',' with '.' as the char that ends the +T:name.
> >
> > This allows a later patch to treat ',' as a space, which mostly
> > eliminates the need to quote query/rules.  And this in turn avoids
> > quoting hassles:
> >
> >   modprobe test_dynamic_debug dyndbg=3Dclass,D2_CORE,+p
> >
> > It is particularly good for passing boot-args into test-scripts.
> >
> >   vng -p 4 -v \
> >   -a test_dynamic_debug.dyndbg=3Dclass,D2_CORE,+p
>
> Could you please add example how it looked before and after?

Before a user had to issue a command in the format
modprobe test_dynamic_debug dyndbg=3D"class D2_CORE +p"

Now a use can use either
modprobe test_dynamic_debug dyndbg=3D"class D2_CORE +p"
or
modprobe test_dynamic_debug dyndbg=3Dclass,D2_CORE,+p

> Is this format documented somewhere?
> Will the documentation get updated?

Documentation will be updated.

> Could it break existing scripts? [*]
>

It should not break any scripts as this change does not change the
interface but extends it.

> The dynamic debug interface is really hard to use for me
> as an occasional user. I always have to look into
> Documentation/admin-guide/dynamic-debug-howto.rst
>
> Anyway, there should be a good reason to change the interface.
> And the exaplantion:
>
>    "Let's use '.' instead of ',' so that we could later
>     treat ',' as space"
>
> sounds scarry. It does not explain what is the advantage at all.
>

I will clarify in the commit message that this change allows to use
two formats either
modprobe test_dynamic_debug dyndbg=3D"class D2_CORE +p"
or
modprobe test_dynamic_debug dyndbg=3Dclass,D2_CORE,+p

>
> [*] Some scripts are using the interface even in the mainline,
> for example:
>
> $> git grep "dynamic_debug" tools/testing/
> tools/testing/selftests/bpf/test_tunnel.sh:     echo 'file ip_gre.c +p' >=
 /sys/kernel/debug/dynamic_debug/control
> tools/testing/selftests/bpf/test_tunnel.sh:     echo 'file ip6_gre.c +p' =
> /sys/kernel/debug/dynamic_debug/control
> tools/testing/selftests/bpf/test_tunnel.sh:     echo 'file geneve.c +p' >=
 /sys/kernel/debug/dynamic_debug/control
> tools/testing/selftests/bpf/test_tunnel.sh:     echo 'file ipip.c +p' > /=
sys/kernel/debug/dynamic_debug/control
> tools/testing/selftests/livepatch/functions.sh: DYNAMIC_DEBUG=3D$(grep '^=
kernel/livepatch' /sys/kernel/debug/dynamic_debug/control | \
> tools/testing/selftests/livepatch/functions.sh:         echo -n "$DYNAMIC=
_DEBUG" > /sys/kernel/debug/dynamic_debug/control
> tools/testing/selftests/livepatch/functions.sh:function set_dynamic_debug=
() {
> tools/testing/selftests/livepatch/functions.sh:        cat <<-EOF > /sys/=
kernel/debug/dynamic_debug/control
> tools/testing/selftests/livepatch/functions.sh: set_dynamic_debug
>

Good to know. I will use these scripts to make sure the dynamic debug
interface is not broken.

Thanks,
Lukasz

>
> Best Regards,
> Petr

