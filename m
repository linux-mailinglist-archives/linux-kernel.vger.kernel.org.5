Return-Path: <linux-kernel+bounces-119879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E6288CE1D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 489A31C32FB5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B81C13D504;
	Tue, 26 Mar 2024 20:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DA2w8bRV"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5041B2AD2C;
	Tue, 26 Mar 2024 20:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484269; cv=none; b=Q4L2LAOHTMxkiAARozHyd0Pj5etc+/nLKjl1bszQqK1ysKkYb8UXqyt+o5Z673yUOC2JbGwOZy/y5W15UFsv6yDdS0mgta+HVDOox0tJaPVU0DBDG27gXMGbiYHTSxSTmlBy0s7c2I/ldDXvrKWpjp28PXyk7shWWfioWFEso3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484269; c=relaxed/simple;
	bh=l0PAwS1wlrqxNRSQuJrQPY3+Q45IBLEvftbyUMrb048=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jb8RQFpZbOtGyoglxPPaJ60Ip3QlSoIZRw9UaaWccK2xDNURLtVj6M/ae+yr375vyp+6LAQ0+Jjq4OSLDD4Wu6CvfxoQX3whM3ZPEJ2skmMIaavmUf/73bxxa/yDkXtbGZ4NjcRT3LAJLiD5bs+wYyGt1eKgF6eN6lKFhFUY3v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DA2w8bRV; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-60a046c5262so56857677b3.2;
        Tue, 26 Mar 2024 13:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711484267; x=1712089067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rh3YW0AOZPmvBcjKfoYP1w8P/SW8q70+JN9/BHH1CxE=;
        b=DA2w8bRV5SCFuWH3CARhUfEAofPgnZnmI4mfN13AMAcLPfeMYmYcGys+WPNpg1EEqK
         fbjDDnrTXyZ+AI23hDjc5sVkIT1nuVlvLFKRMm5eUWsX9vIv2NWKb2IzakDle9mxkuXb
         fUMq2Z9RylMb9lQaZu03jpMJJqnLxsEouYDK8TxRCwj6tn08cFowyUuWqi/QYdk1xenM
         rsnNQy15wg20Esoe2RhqPFqYMHfjX+2iqITyU/ICUlfzYpSMAr9gk5j/vFlDCMESW/TP
         j/+znKWDq0rn4EYOUqJeaSwB1mqcngCLlEPiprJXHutE/eliAHJlW8+C7ELzesD5P5a1
         UP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711484267; x=1712089067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rh3YW0AOZPmvBcjKfoYP1w8P/SW8q70+JN9/BHH1CxE=;
        b=ggQ3oOqhhADKRwhxWNaTC0mJcXFoHUHAxsAMcga/iFjFWBcl8R/UcpOeEdVbUXy0PC
         7pb5PWuSGMpIyH3PymA8vAB5mC4ImLJse+I+Zp6/7JSFu+kJjlEiGMIXPAXe/yneQXxy
         l926TFqv56yD8RDTnmjqSeeNgYq1Smy/X7dxXYjBwVB6RxWvnxC+6BYEbjh1yJ5yuYiH
         H07AxJp8PdmCjcr0fbHn1SODtUKm+I0mDqJFD4D1qDSS/ilELncika/8vAwIsKUSt5/T
         ZXQhAsvDs6h4MdPdi5QZJIdlVK2H12sdgKtLJ7Fv6kj5+Zw/55KijPmHl8JGIJHJZKMt
         lScA==
X-Forwarded-Encrypted: i=1; AJvYcCXU0EQYjzAR5DbmcrGq0levPPyszVErgFh69R0n8u5E6Se8Fy4cSXHK2cJsBLzLfXoVr90CU6ApfGRCliLco10uih/TqaO/F4OT+Yx3HwRCXA2c7fCE3akRzTu9cRqnBjzMBaDTjOwAfx+mikOArbGjp36450Esx28xqN7ONoL6pyiBxw==
X-Gm-Message-State: AOJu0YzI5B72kYCcyiMoUKk5hqrSq8lEBq3PEcv24KE+TIDODFbNEiUN
	D8wNVMEX302zqB5nliBahEBs7B+dYc5BVg5jCMMyF2wGiAnCb+ZfmA+rzjROfl8O4kBAvVK1btY
	09ubmS7uHnw11yqzC1ipAoJ/ppjM=
X-Google-Smtp-Source: AGHT+IEq2DLXMHVyXMCQwnTcmcIMKlEbMRR9WzaSE8uHUUfLZEFBAzdAE0HEkuyUY9Qwy+5HaX/bY7RP0ttLMl20OKA=
X-Received: by 2002:a25:a2c5:0:b0:dcc:467c:cecb with SMTP id
 c5-20020a25a2c5000000b00dcc467ccecbmr8989710ybn.37.1711484267271; Tue, 26 Mar
 2024 13:17:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325153356.46112-1-l.rubusch@gmail.com> <20240325153356.46112-5-l.rubusch@gmail.com>
 <f74a01bd-46a3-46cd-a47a-fcfccd7e4dc6@linaro.org> <CAFXKEHbJ_5unY24aZeutvM-xrjevQ=z7ngDcgwJR=NXzXONx5A@mail.gmail.com>
 <334970e7-2edd-43c8-9f18-b7b3ec5f4d17@linaro.org> <CAFXKEHaEVwiAW9co0+=kZ5w5a8eWg3QL0dmg38bvrmLdnBEA7w@mail.gmail.com>
 <b13ca51c-db57-4a09-b689-cf27265d348f@linaro.org>
In-Reply-To: <b13ca51c-db57-4a09-b689-cf27265d348f@linaro.org>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Tue, 26 Mar 2024 21:17:11 +0100
Message-ID: <CAFXKEHYMiARxrN7=jqnJtEVREseZ-zmZmVeY1uNXZV6viwHbmw@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] dt-bindings: iio: accel: adxl345: Add spi-3wire
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 7:30=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 25/03/2024 23:09, Lothar Rubusch wrote:
> >>
> >>
> >>>
> >>>> the tags. The upstream maintainer will do that for tags received on =
the
> >>>> version they apply.
> >>>>
> >>>
> >>> I'm pretty sure we will still see further iterations. So, I apply the
> >>> tags in the next version, already scheduled. Ok?
> >>>
> >>>> https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/proce=
ss/submitting-patches.rst#L577
> >>>>
> >>>
> >>> Going over the books I feel it does not make sense to still mention
> >>> feedback ("Reveiewed-by") for the v1 or v2 of the patch here in a v5,
> >>> does it? Your link mentiones "However if the patch has changed
> >>
> >> I don't understand. When did you receive the tag? v3, right? So what d=
o
> >> you mean by v1 and v2?
> >>
> >
> > V1: The first version of the 3wire patch. I have split the single
> > patch upon some feedback (yours?!) - V2... So, my current
> > interpretation is, that every feedback I need to mention as
> > Reviewed-by tag, no?
>
> What? Feedback is not review. It's clearly explained in submitting
> patches. Please read it.
>

Exactly. My missunderstanding here is this:  Why did you send me a
reminder that I forgot to add "Reviewed-by" tag in your last mail?
Could you please clarify your last mail? You wrote:
"(...)
This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions, (...)"

AFAIK noone literally had told me: "please add a Reviewed-by me tag",
or did I miss something? I'm a bit lost here, sorry.

> Best regards,
> Krzysztof
>

