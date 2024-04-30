Return-Path: <linux-kernel+bounces-163614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7698B6DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 806731C227A6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39736127B58;
	Tue, 30 Apr 2024 08:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLp/sdfd"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823F11EA6F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714467556; cv=none; b=ncd0uMNKSUfZC2MbfsxplUzvgyrzpFWkS1WVBcALwoHyGoZ7D0sd2zBZD3VXIViXRn6l15iJVM8eN/OYU0I5+IGnCjE/LJjltL8E/MxG1jIRdS4rxin28wJB5yZ4/v0Nt1P+78WYQQ2TDu94gGXN7CkPayF/cQ7Bs1GLpaj6GHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714467556; c=relaxed/simple;
	bh=XEZN4ftANSkOUwo0Ao+ufzppjZ3mIIc1ejZvjfMnPac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9ZdYvzQGkqsBnBtDFsWNDs4mxGVWRWVYSk4JBdLeXX263i9VWhHIvCdQVkHiFtlcXnuC9MC3h8+XQVSudNC4F65w1NzIS4zhqAWG5veR3Cu9/TV9lLgwci43bb2SWb3i3IrinTskzlIFsX8rBYGUMnqQSLKv0tjVECmacRgkf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLp/sdfd; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a55911bff66so660588366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 01:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714467553; x=1715072353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwoS6roGJS4Z269frSZO0uwgn9TLAcJHwh4SPFyzbwM=;
        b=NLp/sdfdVm542p4vzovUwHv2i48gZFfPtMoJlg0xsO06FZ0kDsU5nODzBBOdfa8VWQ
         UrdGY0eBSUB9W4C4ahqpFLjnLNB7iGo7WLgIBLgryUJyBHZAMr5LOO/HZLZsOoULO//E
         RFd7uDnLJnawUkUoodVYWM8165TiIyvjMV9C7K5+/MoVThXaBOp5RvOGyqNbaLtnFsCl
         WH3+g5yYSA9lUUV6T5xyw43z4gw+isoNowzzXk+xrkNlU+NOSpkJOSfNvAOe5AWiMv+s
         vKPsjretXUqy+o+J4IonBvzo3vcCiRfUj4oLPX/n7KMc79UeWm+LQdTUuLYBy8pj4mC4
         YZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714467553; x=1715072353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GwoS6roGJS4Z269frSZO0uwgn9TLAcJHwh4SPFyzbwM=;
        b=wJoGqz0z1aWGn+xPZskNL1v5bSHgCb6TasMn7JYtDN6e2Io6VFcwBsWzhC/9BcRWgh
         q6WbIoDhFh8TXu0QHADp2oAL0ygObJ8sT2cA8l59Yw2nhZBGLDVZyrH8v80vFEOk8cJI
         Dog8ibJDCIWgYrr/xuuSh0f2jp/XQeRdx1PslkJnvlAjMqnTOLykX1uJRXBxOYa/HHVI
         R6fgkqsC3IfYqpN8BY6rc9IWDufGngkusqixJdg61zSsjNFs3pK4Zq3nf9FDKumXS8Pe
         Lpz2kO5qkCilXnU53mmxVn62hxXILpA7kEN8Xke4qEm/5+/UP/MZbCuIVG2fDix18G5q
         GI+w==
X-Forwarded-Encrypted: i=1; AJvYcCXtxkysr4+ZKFaCOEMKEcfUUfW5hqdi8412liZRU/jxwn69A8zb3zn63KEKuqF0DY3jBqlKNYkF9bUL/EVO/IwrCTrmWyMosQ1oxB2g
X-Gm-Message-State: AOJu0YykqyOG4eh6ADpIhbn7UD0VItB44vCdEmj2+8LyvpUIPKGIti8z
	G68UeSSbwEbCPyaltcrzk5SNTghA0FCF4lNOCGJPZSDkuN9MzNZL3jiD6ZvhSkQIaHZgoivKfVu
	YhMmAfbHqNVJ21CZ2eIAmU4YfwM0=
X-Google-Smtp-Source: AGHT+IEZohtI/5LTZiqwo7rznZUIE8iyJSNBnS8rQMpXNDtqEGP8p2WDFpXtRV8D0nNGk0vPJwn0jPmb0AfHIyExETQ=
X-Received: by 2002:a17:906:71ce:b0:a57:2cef:89c0 with SMTP id
 i14-20020a17090671ce00b00a572cef89c0mr6701926ejk.67.1714467552611; Tue, 30
 Apr 2024 01:59:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430021753.385089-1-brookxu.cn@gmail.com> <8379e4a9-3114-4d35-9d1f-81ca61351b85@nvidia.com>
 <CADtkEechcseDatdzoPDrYBapvQ5iTKo3E-tsdiwj2B7euLLwnQ@mail.gmail.com> <c5495a06-1edb-4097-ab77-280955d14a56@nvidia.com>
In-Reply-To: <c5495a06-1edb-4097-ab77-280955d14a56@nvidia.com>
From: =?UTF-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Date: Tue, 30 Apr 2024 16:59:00 +0800
Message-ID: <CADtkEefA_eLKTDOJo7GcoaYGhWXbyyA6WCTE-Z1aMpA7bpwRvg@mail.gmail.com>
Subject: Re: [PATCH] nvme-fabrics: use reserved tag for reg read/write command
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>, 
	"kbusch@kernel.org" <kbusch@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>, 
	"sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chaitanya Kulkarni <chaitanyak@nvidia.com> =E4=BA=8E2024=E5=B9=B44=E6=9C=88=
30=E6=97=A5=E5=91=A8=E4=BA=8C 14:59=E5=86=99=E9=81=93=EF=BC=9A
>
> On 4/29/2024 10:10 PM, =E8=AE=B8=E6=98=A5=E5=85=89 wrote:
> > Chaitanya Kulkarni <chaitanyak@nvidia.com> =E4=BA=8E2024=E5=B9=B44=E6=
=9C=8830=E6=97=A5=E5=91=A8=E4=BA=8C 11:47=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On 4/29/2024 7:17 PM, brookxu.cn wrote:
> >>> From: Chunguang Xu <chunguang.xu@shopee.com>
> >>>
> >>> In some scenarios, if too many commands are issued by nvme command in
> >>> the same time by user tasks, this may exhaust all tags of admin_q. If
> >>> a reset (nvme reset or IO timeout) occurs before these commands finis=
h,
> >>> reconnect routine may fail to update nvme regs due to insufficient ta=
gs,
> >>> which will cause kernel hang forever. In order to workaround this iss=
ue,
> >>> maybe we can let reg_read32()/reg_read64()/reg_write32() use reserved
> >>> tags. This maybe safe for nvmf:
> >>>
> >>> 1. For the disable ctrl path,  we will not issue connect command
> >>> 2. For the enable ctrl / fw activate path, since connect and reg_xx()
> >>>      are called serially.
> >>>
> >>
> >> Given the complexity of the scenario described above, is it possible t=
o
> >> write a script for this scenario that will trigger this and submit to
> >> blktest ? not that this is a blocker to get this patch reviewed, but
> >> believe it is needed in long run, WDYT ?
> >
> > Thanks for you reply, I can easily reproduce it in my VMs by following =
steps:
> > STEP 1. In order to reduce the complexity of reproduction, I reduce
> > NVME_AQ_MQ_TAG_DEPTH from 31 to 8
> >
> > STEP 2. Create a nvme device by NVMe over tcp, such as following comman=
d:
> > nvme connect -t tcp -a 192.168.122.20 -s 4420 -n
> > nqn.2014-08.org.nvmexpress.mytest
> >
> > STEP 3. Buind and run the c++ program issues nvme commands as followed:
> > #include <sys/types.h>
> > #include <signal.h>
> > #include <unistd.h>
> > #include <vector>
> > #include <set>
> > #include <stdlib.h>
> > #include <sys/types.h>
> > #include <sys/wait.h>
> >
> > const int concurrency =3D 64;
> > std::set<pid_t> chlds;
> >
> > int __exit =3D 0;
> > void  sigint_proc(int signo)
> > {
> >          __exit =3D 1;
> > }
> >
> > int main(int argc, char **argv)
> > {
> >          signal(SIGINT, sigint_proc);
> >
> >          for (auto i  =3D 0; i < concurrency; i++) {
> >                  auto pid =3D fork();
> >                  if (!pid) {
> >                          while (true) {
> >                                  system("nvme list -o json 2>&1 > /dev/=
null");
> >                          }
> >                  }
> >
> >                  chlds.insert(pid);
> >          }
> >
> >          while (!__exit) {
> >                  if (chlds.empty())
> >                          break;
> >
> >                  for (auto pid : chlds) {
> >                          int wstatus, ret;
> >                          ret =3D waitpid(pid, &wstatus, WNOWAIT);
> >                          if (ret > 0) {
> >                                  chlds.erase(pid);
> >                                  break;
> >                          }
> >                  }
> >                  usleep(1000);
> >          }
> >
> >          // exit
> >          for (auto pid : chlds)
> >                  kill(pid, SIGKILL);
> >
> >          return 0;
> > }
> >
> > STEP 4. Open a new console, running the followed command:
> > while [ true ]; do nvme reset /dev/nvme0; sleep `echo "$RANDOM%1" | bc`=
; done
> >
> > We will reproduce this issue soon.
> >>
>
> cool, can you please submit a blktest [1] for this ? I'm not sure if we
> have any coverage for this scenario ...
>

My pleasure, after reviewed, if no more doubt, I will try to do it, thanks

> -ck
>
> [1] https://github.com/osandov/blktests
>

