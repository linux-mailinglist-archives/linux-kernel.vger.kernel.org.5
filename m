Return-Path: <linux-kernel+bounces-16597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F6F8240DA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99FA61C2181B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48246219E5;
	Thu,  4 Jan 2024 11:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8zsJf+t"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B0E2136F;
	Thu,  4 Jan 2024 11:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-595ac2b6c59so173847eaf.2;
        Thu, 04 Jan 2024 03:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704368570; x=1704973370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAgP8YYefZBKQ2T5DcbZSgvKWru2EMjpy0dzt/PCz5o=;
        b=N8zsJf+tAXDu0BXtfesKgFgojA0cPRquguC8sdIOnD7lRgfK8c9w1L1lx4F2Yd6LBs
         CuTB1xmIDemABOATfV/I9YYe42NHEu4H3IFp1Mqj+jz4H7Ru072xlD9bMlbgiWVaqPqi
         bpExS7fuatHBr5V1QsrtExtFwquXEZRg0gpe0MoQj9fBab1oS1hBPUMjMxZukregYQCa
         8M2VBUBXGKpUXfzNrFkjh6Sp7V0GvF0Yn5E4YVRXvNuIXhKI6ZuppGmsMxl71lP9cOtX
         uZBr67GQBFPAlI3yr7ALbIHtkjBewHDuVDzjXz3OK0PkBYCFGLt+nM34sJArNEMjDcTK
         ybXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704368570; x=1704973370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAgP8YYefZBKQ2T5DcbZSgvKWru2EMjpy0dzt/PCz5o=;
        b=RHtOpPZ75opi8IpUWezCij3RkdGW8C5MxqCx5YjyzCqqzUWDSXaVXiT3wIsaWVp1LX
         0EOtZ5N+4vvXIJ6guaZfSl1P7nOKOhsCh7at/7S3qHtyb4S4VheU/e8cFRL3Gqd+/Foo
         mmqtk60zNnefGvhsmRrGZeEWppbeaL0L+J1kOQWFUuTXRUjVnBlLpGdfj4jk1LaXM+Y4
         Ot/V8hDA9rNk+Vdb/mW6yrhbdKHv9n6gRSXIWgZ4avpRQVBUBfc5rbWIJ7lVrfz/TUcK
         uubBTheiHccgUMJxV7AND91EX/+etCPSHM9OIsAHiQOJA/ZjCy0oP2tcO4GhEu+ufqoi
         4eqQ==
X-Gm-Message-State: AOJu0YxDakr+LDNt+/aqtj0lGmBDXyvAuFj92OPGKVVlakgZ+K+JnNof
	dBJZBj6Tt9EVtpKbmKYLykfqRwnouBh78vUJ+eg=
X-Google-Smtp-Source: AGHT+IFGeowPpRL12vIrpg/nC+3rhIYAcJLTNy2TO7c3CiW6lZkgk7lwX3CM7Zw5cwXPd33np0igfHm5oWLm4XYcxYI=
X-Received: by 2002:a4a:b045:0:b0:594:406:4416 with SMTP id
 g5-20020a4ab045000000b0059404064416mr420529oon.8.1704368570083; Thu, 04 Jan
 2024 03:42:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231229090643.116575-1-qiujingbao.dlmu@gmail.com>
 <20231229090643.116575-4-qiujingbao.dlmu@gmail.com> <942d79d0-08a8-4cda-90de-57daa44d9dd7@linaro.org>
 <CAJRtX8Rv0Ws=fcgDf2jh6GRz3ba+CkjH4u6JUPZnN61-CqqzZA@mail.gmail.com> <73dc5e85-0442-4b48-8abb-4a323403f3c0@linaro.org>
In-Reply-To: <73dc5e85-0442-4b48-8abb-4a323403f3c0@linaro.org>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Thu, 4 Jan 2024 19:42:39 +0800
Message-ID: <CAJRtX8QKyGDrCa_L8YY_Bsy3TTJsfw0LOt2T8uLWEfKE9QrQDg@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] dt-bindings: mfd: sophgo: add misc MFD for Sophgo
 CV1800 series SoC.
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: a.zummo@towertech.it, alexandre.belloni@bootlin.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dlan@gentoo.org, inochiama@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 7:16=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 04/01/2024 12:05, Jingbao Qiu wrote:
> >>> +
> >>> +required:
> >>> +  - compatible
> >>> +  - reg
> >>> +  - rtc
> >>> +  - por
> >>> +
> >>> +unevaluatedProperties: false
> >>> +
> >>> +examples:
> >>> +  - |
> >>> +    #include <dt-bindings/interrupt-controller/irq.h>
> >>> +
> >>> +    misc@5025000 {
> >>
> >>
> >> misc can be anything.
> >
> > Actually, there are RTC and (Power On Reset/POR) here. I can't find a s=
uitable
> > word to describe him. Can you give me some advice?
>
> Then maybe just rtc? If there is nothing else, why RTC is separate subnod=
e?
>

There is also a por submodule used to provide power off and restart functio=
ns.
Do you mean to use RTC as the parent node like this.
rtc{
    //something
    por{
    }
}

Best regards,
Jingbao Qiu


> Best regards,
> Krzysztof
>

