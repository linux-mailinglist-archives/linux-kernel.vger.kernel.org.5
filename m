Return-Path: <linux-kernel+bounces-137083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C6489DC29
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B8C81C21A1C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AF612FF6D;
	Tue,  9 Apr 2024 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gj1lWbvN"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DEF12FF63;
	Tue,  9 Apr 2024 14:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712672619; cv=none; b=NIC0N5a6Ikdb6al2nB59EaCT+cLtlDiVGafw5XYWq3og7bciWFfXEzovCQtkn6E7MGxBgCqfSOg201aOTquk8pCxWwdS8jipDw7pHyaw5EUwzb1JWNXNijCU6PYuhfpU8FMOctdHqtuxJBRHVPIVYLpjDcgkAB129SadcHEKu5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712672619; c=relaxed/simple;
	bh=Ty2f8pnPcBEyF3m2q3oawb8ksrgM+TTBnxPTrXpEtjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IMMYhvkpwIfmj5eslW1qVK/HnIrpmcyljTQebxHR2D4d1AKpZzktleCLvyVynCSZHCi40ScpqdDDV0hPKpuM163NLl2AE0NkplTarBG4LAu6Icnacew3v1cRu7naH1T1V7GM2LA68SWVDu44TRIPE5Q4KN757zYpwyjoIBqcqQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gj1lWbvN; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d4979cd8c8so52954501fa.0;
        Tue, 09 Apr 2024 07:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712672616; x=1713277416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhWsMOQgYV9auXE9rRgSy5tpt3ezoTRv+HC7Wl6JmUg=;
        b=gj1lWbvNdywQTL/j2YqPf5CG2bUrE7QKzbbwR07vFhInamUAgCW6T8OHJK2PH1WXCD
         goEB3M/7cAElahKj50ucy+HFe9SjMcvoN4/IFS36xHKRjAya92el3MwQA+X3bpGDzAX4
         lIE0CbkKj4zX7rt+QHH7MaOdz3Qe5HqUzqpELHQaoeCZCIBVIeKqyz6/qhPd0lDUn0de
         yYvj9xezjANNX7kUqCguTd1+yXh4rubFj3A4K/8ptPG+66JfYhXi3HYwBCNPJNdsQEf3
         EQi5lNfVUxFmBEI7liV+eV8o8gqLNyNHK1iYa5iFgvECukI32K0o0o7KmhQR1FNNbcHf
         vxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712672616; x=1713277416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BhWsMOQgYV9auXE9rRgSy5tpt3ezoTRv+HC7Wl6JmUg=;
        b=pOWs92eg667NofbAWt9BfrzYcmb+tSDTrrwcpB/j4RsbcpVz1B4811fNDJ9ws7+xuU
         CeITR3Osz74I0CSyKrxS0zdNp2hk2nI64Ohiw7FkyXAxM4D2Rv3NkiN3aHsnaoM36XIE
         UFsMUZaZhhcRuYnFAtiGi7lVuc3k2+FQ8fp5OCi5s1R3dD3hHCc6LnUbhQOU9U7kXyEz
         2q5tk/bcg8sb9rnpl1QYNFvYSFzMF47fb1Of/eVpg7NQCT9kk5ukWEmgh9eln6A70OJD
         iiA+cHFEZLrkQ7vPaSwu47eRT/F1ssz+Wgpo9xLfvyLSgdt8/3GqbUP8vK9MtSRZESMw
         YiXA==
X-Forwarded-Encrypted: i=1; AJvYcCUrQr+KJU4GwVSMX/YL+OA/iqi9dSFkiOUWZCtxJ/Uxi74+JZYoxDkkeEbj9nRocj5J4WFTRyDrHAW74vq9QdcePbbVEkRXUZj72YCaDLLR6lnUUxlzFU54rvQW5DxlQGv4LclaW3pscqnqyATo
X-Gm-Message-State: AOJu0Yyfgg1e4pwiMcC/pkJUJQoGh2CeJQwH8NQuN38tcLd0nn+sRaiY
	BG4JUtIxXyLgy7b/MNz78og1faoxHz5XlZ2BO+YeSv7LCmxh98ztqlLFs6o52MMvduN1uAdAKmE
	b2R2IQOHOhuN17RshkFwK+FZPope/edS3VRE=
X-Google-Smtp-Source: AGHT+IGz1jFaS6SRwv5iWAR2VPLNxDGE3/BU8tCAxZQ+8qGx7loUh+88mJoj8KZrkQFz1WMtEzF4mVP/Vjk6KnqQ9AM=
X-Received: by 2002:a2e:b16f:0:b0:2d4:79ff:5573 with SMTP id
 a15-20020a2eb16f000000b002d479ff5573mr881657ljm.20.1712672616060; Tue, 09 Apr
 2024 07:23:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408123459.66504-1-wse@tuxedocomputers.com>
In-Reply-To: <20240408123459.66504-1-wse@tuxedocomputers.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 9 Apr 2024 10:23:23 -0400
Message-ID: <CABBYNZ+DNkb4bC8eSQaxcDFEuA4hWJMgk00r6+YKc+BH953x+w@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btintel: Add devices to HCI_QUIRK_BROKEN_LE_CODED
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Christoffer Sandberg <cs@tuxedo.de>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Werner,

On Mon, Apr 8, 2024 at 8:35=E2=80=AFAM Werner Sembach <wse@tuxedocomputers.=
com> wrote:
>
> From: Christoffer Sandberg <cs@tuxedo.de>
>
> For HW variants 0x17, 0x18 and 0x19 LE Coded PHY causes scan and
> connection issues when enabled. This patch disables it through
> the existing quirk.

Perhaps the following could be a proper fix for that:

https://patchwork.kernel.org/project/bluetooth/patch/20240405204037.3451091=
-1-luiz.dentz@gmail.com/

If you manage to test it please reply and add Tested-by to its thread.

> Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: <stable@vger.kernel.org>
> ---
>  drivers/bluetooth/btintel.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index cdc5c08824a0a..9f9c4696d082a 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -2881,6 +2881,9 @@ static int btintel_setup_combined(struct hci_dev *h=
dev)
>         case 0x17:
>         case 0x18:
>         case 0x19:
> +               /* 0x17, 0x18 and 0x19 have issues when LE Coded PHY is e=
nabled */
> +               set_bit(HCI_QUIRK_BROKEN_LE_CODED, &hdev->quirks);
> +               fallthrough;
>         case 0x1b:
>         case 0x1c:
>                 /* Display version information of TLV type */
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz

