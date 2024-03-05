Return-Path: <linux-kernel+bounces-92761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1208725A2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1212F1F26F96
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5DF168DE;
	Tue,  5 Mar 2024 17:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kf+SqNR7"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A442714016;
	Tue,  5 Mar 2024 17:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709659708; cv=none; b=hJdE2fXbJPJYQRXgnl9M+8pWIXbOhF0R6ji+gOTBMDlHatdbOondUpQJa/TzlIMAHYHpj5Klm4+6sOfLE36xnDjjKsKslSlMYK0/zJlfuP/xBY10xmKvT5z2VClrYJ5yxknVzjKIAOcS/jWpT0gsQsQZM1ooZjIQt4RJf7jvxyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709659708; c=relaxed/simple;
	bh=kNW5t8ukzxzZT7xpKqZojeyvFn3Q0ntJqTrSqBZhfKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brF7lwEoIAYMsZKKW3sBjBUVwU16Cl3cGrTr5oVoQfbjIDB+z6NGYZv0FVQOdFnKRRM0o1AX+GwF2pos05unyWM6NyyAlRzexfzqlAnZgRWMF5MlUjRfurvHTQ6ux4eL3uDBt6OPkSBRX0NbF1pz0CvTN/dgTUPlB/bmhQTDExg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kf+SqNR7; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e4d48a5823so4733924b3a.1;
        Tue, 05 Mar 2024 09:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709659706; x=1710264506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OcJq8X/piv1pkzdTu6ce3o3Fk2RAorMlIkYhy16kiAc=;
        b=kf+SqNR7Aq8kpGMsIR0XCGX0ssyyF28dBIgXIcotp7oeWLBzc9xNqCX98wHnHDRk+v
         ddIJ8wweI4Zu2kuq4MQUMRP/dxKlB4awxHjFh16zst6Lkucv7fMosCZJsZvWex8aghUk
         ZmLcwGMUZou5ZdmmbvMXubf7m90UT3vXApuRiv/f3JCR6FpeEkER8TTJQOqg2uOOUBBR
         wrdEbTO76mOCYdV2AHaf0XaF/XWqAW5CLTeRQ01pYNRqXpszDKKaSzISRSEx3uerlO95
         zQ8XGZJVlSCKMq7synPMQi9lvtSASVHHwPONnLKOZI5hxK/M0N3GV/viCtWVjo7fKQ90
         dvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709659706; x=1710264506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OcJq8X/piv1pkzdTu6ce3o3Fk2RAorMlIkYhy16kiAc=;
        b=rVLFJ41Kz49wQqKPjw0zAzD9u07x9hz20mlBO3qke+52Cuy3Sq8o6kBQPg2rOk2sNW
         vU3z2tX0g98+vXi7d7v6D+qndAJyVjQCo0a/0M7+Tw8NAqo/2S4M/BOE6pkP6AmOiZf5
         kQrvV/ZNXWW6QwW0FntJ7FMwJZAMnpLAiuJzOqD3VTujzaEBpzQDhsniatFp1Py4EXTf
         rgjNKwBfBJccIA9VtzSOAXP2X29nicSeyaRcn4msvT2mkYVfAoS8bnyybi60p9KQKotz
         db+GWMgQ/3X6yJer/8adPgY+aD7T07E6JkCpRmkl+DALE+uTjUwJsswEySw2FChuNqhe
         ud4g==
X-Forwarded-Encrypted: i=1; AJvYcCWOgeMleaVddBTpZVbbalccmh9N6y7VipMgjf6V2v0Pj4RyJtd/E6UHAKiEJAK8W+UyPHbxVWZlSUav8RpIK/IlF2lDDhJogJtqwY3K
X-Gm-Message-State: AOJu0Yz3Fw5s7VOID6UHQSiMk4AXvF14VYGbQynbQYvqmedRFc1NTh0u
	WoKcauhxT1mc3sZ72HWo4yYUfhv8M2aqBdCEPQ79uUOIsxKzcfO4cb4yCI6i
X-Google-Smtp-Source: AGHT+IEmOJ2e62dItA6FE7sEszI6bKvV3r+isvq7qUT76xII69ekEac1IyttXdhHW04mI+Y0wmmaoQ==
X-Received: by 2002:a05:6a00:18a9:b0:6e5:6589:f949 with SMTP id x41-20020a056a0018a900b006e56589f949mr14544619pfh.1.1709659705670;
        Tue, 05 Mar 2024 09:28:25 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:a5d5:fe74:fba8:86b5])
        by smtp.gmail.com with ESMTPSA id r5-20020aa79885000000b006e530aca55asm9232463pfl.123.2024.03.05.09.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 09:28:25 -0800 (PST)
Date: Tue, 5 Mar 2024 09:28:22 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Adam Ford <aford173@gmail.com>
Cc: linux-input@vger.kernel.org, aford@beaconembedded.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: ili210x:  Allow IRQ to share GPIO
Message-ID: <ZedWNlNaJQEWdA9a@google.com>
References: <20240228114142.43803-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228114142.43803-1-aford173@gmail.com>

Hi Adam,

On Wed, Feb 28, 2024 at 05:41:42AM -0600, Adam Ford wrote:
> The IRQ registration currently assumes that the GPIO is
> dedicated to it, but that may not necessarily be the case.
> If the board has another device sharing the IRQ, it won't be
> registered and the touch detect fails.

I do not believe the driver is prepared to handle shared interrupts.
First of all, it disables interrupts in the firmware update path, which
will interfere with operation of other device using the same line.

You also need to make sure the driver properly recognizes condition when
interrupt is raised by another device and Ilitek controller does not
have any data to transfer/return. In this case we need to make sure we
do not log any errors, not release any active contacts, etc.

Thanks.

-- 
Dmitry

