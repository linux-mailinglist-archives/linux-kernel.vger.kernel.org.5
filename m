Return-Path: <linux-kernel+bounces-136090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD8889CFE5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02C48B24527
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929598F77;
	Tue,  9 Apr 2024 01:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9d0zUae"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7978F59;
	Tue,  9 Apr 2024 01:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712626638; cv=none; b=RiZIoZ5a8HjZbJ+mIgDFfz1gjUY5ub+qoyad/b/gWbj2GeYe84yiY69WS0sQIgyLQjjOFntKdY+j0jeOaLnxUYe63FZ8ZBwdqUMevs+Ce7mneDAjVeVkdGsiL5T1rBU5naAXky6u5UNkV37lWbn9EahBnU9fToUy6EmHkCnCRvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712626638; c=relaxed/simple;
	bh=REUfQMGxi6wZBiAigJvmtnxlwEZNsiAI6JDcOF9qSOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SBCIHpfeJtTROvTCPMcnscLCuf/NqdZsHwk1VyrdkXF19xcSU2PUR577GSwTTpELajRG9TmmUiiw60rz134fCERMmKW4MkWkU7UdV8UNCy/QP6+Uuk7x76lvCloOu5d5WudRO3tw5Jz+97hT1zTRPyh7mGk3c1Q3Cdwir+e0PUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9d0zUae; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-36a2ab5a05dso4081395ab.2;
        Mon, 08 Apr 2024 18:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712626636; x=1713231436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lrU41zZbg4rdCONBXZqOnSqD9/BbJGHGI3UVtCYp1A=;
        b=l9d0zUaeoONxcuX2LbObNdcK0dYSs3NetXU1RFkrWEcifa9dLQfxI4F6U7NpfmSQhu
         6smdNTlJHC1zbyZMfqQZx1AhMcgd4ZDlhSfq6Mt84F6nZ/AEomwWYdsqV7FiYq3wtztR
         qPhsBVRPaOeSUtyyBZhUOT3f6pfb2I9ffHRBeUWHFSHhes0hXogufXkBU4KHhVeDGRWt
         HFyOn7jcoPC6HK0tf3xwVb3PpunDOMa7hdrQBbKQmkQbcfP/tj1Ybj6NnSMN11xGrB8P
         ziaWNI5QgSwgRo8Lzraf+QMDGzSQdGo3Fgg3SH+F8oG/8lurfzZ7gZ/hvmiIsHVMOwXy
         VCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712626636; x=1713231436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9lrU41zZbg4rdCONBXZqOnSqD9/BbJGHGI3UVtCYp1A=;
        b=YwQaw3zEKuab/u28VUMbXP4VMtdljCLljenFQu8TvtsUE9/rMBh5dIN1hWv1JY/ZsV
         uIyi2ZkdXKQOwvsS1spy0GHdvMgeF/USXcnbWam2LS22gwqOBszXp7HvOvaq8yBn3+up
         RaT/OC5jCr/T/68orNm0Zb9SlzynErwmtb0X0murso+gwmXoeI9LkEQ7cCn5G2K624QO
         lJ4sERzy9iVevjkXERMz3vNSn38kU6VmGjmWf0wMH67tX7YD1VMtoj1OzcnVVSeclic6
         Roig0g0jzNRm1HOxj/d/rxOvwWtWKvSJD7I6Roce+BcG+fiwmqI+FaDxQcuVLTOT5f/r
         abEA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ5UNMGsx99emP1x/8NGtlSrhZyX/WG29NjQpTvEzWKDSSg+4NNKmCDahmqs7vuDt+wbtzK8JDN3PqVqJnmInKy0PkbaAyCmF0ePJpTuhYsJwl3d+qxCwrGR4Adb7Z1kwD+vcrVggqQOfLoCjMtusd4iY3B2lHH14zhBNi+qHRt+6c3V0i
X-Gm-Message-State: AOJu0YxvbyjPUW6kT7zmN4qUIK+xk9evyrFQ05faQSxrmEKA0/BSq0aC
	a+4s4RrzMaWvpSo7rZpNbOPXwsjNXtc+mhKv1DwXVZFgAQtZOzZ5OyPhV+FMrKLNNCSSbOZCxSE
	dh9dd5QBNDSfKAIwfrypnbOWzLVQ=
X-Google-Smtp-Source: AGHT+IGHBYdqw5WuioZTYaZ1SjiEaQQ73sRjZsGoduAA1jBDzDuGbUyCGX9a6fp37uYrTgH2e7VJ2m+I4JB2tYmbQ2Q=
X-Received: by 2002:a05:6e02:b48:b0:368:aa7a:e25c with SMTP id
 f8-20020a056e020b4800b00368aa7ae25cmr12442798ilu.30.1712626636379; Mon, 08
 Apr 2024 18:37:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1712561233-27250-1-git-send-email-shengjiu.wang@nxp.com>
 <01734d96-bed2-4f7e-bbba-7068f14c822b@linaro.org> <CAA+D8ANiKH7Oc+KAjD_BMp9P2EVeM8Q6dLGFCC8a83bJXUpPEA@mail.gmail.com>
 <69ab2bd9-401a-42ff-90fa-6600dd071722@linaro.org>
In-Reply-To: <69ab2bd9-401a-42ff-90fa-6600dd071722@linaro.org>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 9 Apr 2024 09:37:05 +0800
Message-ID: <CAA+D8AOP6D+xUNF_XJXt-8dMi2qFyVh-Sbe8k67CzvUbnzrwoQ@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: dt-bindings: imx-audio-spdif: convert to YAML
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com, broonie@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 11:06=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 08/04/2024 10:01, Shengjiu Wang wrote:
> >>> +
> >>> +anyOf:
> >>> +  - required:
> >>> +      - spdif-in
> >>> +  - required:
> >>> +      - spdif-out
> >>> +  - required:
> >>> +      - spdif-out
> >>> +      - spdif-in
> >>
> >> Do you need the last required block?
> >
> > Yes,  one of them or both are required.
>
> And? It's already there: that's the meaning of any. It is not oneOf...
> Before answering please test your changes and ideas. I pointed issue
> here and you responded just to close my comment. That does not make me
> happy, just wastes my time.

Maybe I didn't express clearly.

we need at least one of them (spdif-in, spdif-out) in the node.  which mean=
s
that we need to select  "spdif-in",  or "spdif-out",  or "spdif-in and
spdif-out".

So my understanding is that need to use "anyOf", if it is wrong, please let
me know.

>
> >
> >>
> >>> +
> >>> +additionalProperties: false
> >>> +
> >>> +examples:
> >>> +  - |
> >>> +    sound {
> >>
> >> That's a random change...

So  I can use "sound-spdif", right?

best regards
wang shengjiu

> >>
> >> Instead of sending two patches per day, please carefully address the
> >> feedback.
> >
> > In v1 you suggest to change it to spdif?  but spdif may conflict
> > with the fsl,spdif.yaml.   so which name I should use?
>
> I don't understand where is the conflict. That's a different binding.
>
>

