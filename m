Return-Path: <linux-kernel+bounces-96748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5DE8760F9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFA97B20CAB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17711535A4;
	Fri,  8 Mar 2024 09:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNSAuLDq"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C052053388;
	Fri,  8 Mar 2024 09:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709890345; cv=none; b=tDwqwecIP1+T8EM7W6Ry56rfK+DVgYEd0CMyMIiEm6wQxuuB6cimxTQj7zJPrUjmlfTEx7p4yKCQXBEt6VWWSajZVjXfrTATLhH8Yws7hKESNRx+DuXgmzPG4n9Lr7uW8gUTHqDrfIuMj6VKpa5hMUGTwkV1/XrA0tJnqxx28oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709890345; c=relaxed/simple;
	bh=QnO0szRdTsmWrR6KpbcgxmZYiPQ7eKZeIX8N9Y8tJ3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=su9XT77qi+0hiE0jRA6gA/I53SGmy/YVcDkVNx4lbx8K2zPy6TwasaOvZyEv5BohaVLyLuC1qK7/jYOcFG+LGpUtLx6xsZ8GbzWFQ3KXVLUS2Y6D/fCaD4KK+loBJ0tGybJxxDKA2M0hlf05VHmin91Wc7ckOjctTmZh+H9wCY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNSAuLDq; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bd72353d9fso1014867b6e.3;
        Fri, 08 Mar 2024 01:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709890343; x=1710495143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7wrWKLckR9dwH/ul31j0XrWIjQzUvip9OZaiMJtVGs=;
        b=eNSAuLDqmVfXAdKXUl0+vZTPrUXEfUtU2A5lnkXtK1kZLEzEKFLa2pcRvFa4GmwOv4
         WNB1GW6FHru8/NJFjAcmRLO1Fe+qU2STA0BkGenAMhheiaGSAHS18j4s5zZ8IQg4ausz
         bVFek6FIjTWpFrJuhl4OBIPWWxtBD+Xi2+3So9WkNp/Q7g7K1NTbRkR50vWrMstY5rWG
         K5XXW3qAXMk+Wvxi03Vm9Fs6JY07192Y3IFnzqSPvq+KfGIzLau2SmWtzgSF473vLlUU
         Ga1yiP7qzJ2UyEbElLJJssu8LuK3rnEYBTLAfdS4mw1Z2QR91aMLxvMflDRcmGq3Jr/3
         mrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709890343; x=1710495143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e7wrWKLckR9dwH/ul31j0XrWIjQzUvip9OZaiMJtVGs=;
        b=I0N0pd13ERTFVLwWUnB1aLA05jzCeV3AZPrkKzw5+UvYBKK8qywkMPr3QX7auwWkEx
         eKB/S9gK06VwIryEJGAEzL8EGUOvJ11V11317/gD1FWHSBnbmAmiDvjhSEFZC1XTynwG
         9Vt9mMRMNXRkIYgLm2sLtWIEJoWvnys/VcXh94BByKqCKkkqdhV2mZJ0icR+U+yEtRMD
         PyqPbqGNAiJ9+4pEoomXNta6TlqW5dpdADQftYcHOcnRgJWQd0mUxx9hPcx3pDpOW9RN
         YKT1TGm+xDCbQ243ENv+mFtCUJkYKQyZcdjEdbjfOkMvxgjxafDv/tSogTJynjz038pI
         Hj1g==
X-Forwarded-Encrypted: i=1; AJvYcCUuPO5HUWJkrkK9lzeVL8LZaEm80o5H/QZBDjNhNK8tWf7EAuulKjPQeA7VgE/QEECWHIOc7E6H6EYg2v9v2z2Dk0TbRYvl04R4KtEaKgDkhQvv9WLIB6LsQjA7B02/4CCicqKe2PM85mJoZMCSX9w+61igI/o7ARBGGLZ0L7+6pOaBfe8=
X-Gm-Message-State: AOJu0YyLXFAufO96fKzJnP/De5P1BhAD3br4kCl2EN+0+1ZuIjOb0E8Z
	AUnA/ARNJQyyHlBkzWGtMFJ6DH6jb3JKIZXVlCXDB2tbomuSV8rywCd8GACx/UveuiHnaVasy6E
	VeGPZgmAcBhQK51w7pN9WXZIm84U=
X-Google-Smtp-Source: AGHT+IGacdulsw0UFb3sV/FTp+egnN/XnS6ykv5Ng+mKb56dZEwnb3aIMac6MUYw3XaqOLGnIGe4ULUlcpk37CqqAVk=
X-Received: by 2002:a05:6870:819e:b0:221:96fb:9ca5 with SMTP id
 k30-20020a056870819e00b0022196fb9ca5mr1765584oae.33.1709890342746; Fri, 08
 Mar 2024 01:32:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307223756.31643-1-justin.swartz@risingedge.co.za>
In-Reply-To: <20240307223756.31643-1-justin.swartz@risingedge.co.za>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Fri, 8 Mar 2024 10:32:10 +0100
Message-ID: <CAMhs-H_W7WL1ss6Htk8zCxuerF4EzsQR95FfVvdBai1rSCthKg@mail.gmail.com>
Subject: Re: [PATCH v2] mips: dts: ralink: mt7621: add cell count properties
 to usb
To: Justin Swartz <justin.swartz@risingedge.co.za>
Cc: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-mips@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 11:39=E2=80=AFPM Justin Swartz
<justin.swartz@risingedge.co.za> wrote:
>
> Add default #address-cells and #size-cells properties to the
> usb node, which should be suitable for hubs and devices without
> explicitly declared interface nodes, as:
>
>   "#address-cells":
>     description: should be 1 for hub nodes with device nodes,
>       should be 2 for device nodes with interface nodes.
>     enum: [1, 2]
>
>   "#size-cells":
>     const: 0
>
> -- Documentation/devicetree/bindings/usb/usb-device.yaml
>
> This version of the patch places the properties according to
> the order recommended by:
>
>    Documentation/devicetree/bindings/dts-coding-style.rst

Drop these three lines, this explanation would be after --- line as
information about the changes from v1.

>
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
> ---
>  arch/mips/boot/dts/ralink/mt7621.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

With the three lines removal addressed:
Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Best regards,
    Sergio Paracuellos

