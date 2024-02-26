Return-Path: <linux-kernel+bounces-80758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0256A866C26
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9430D1F221CA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E253E1D522;
	Mon, 26 Feb 2024 08:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="x3PaDZ7Q"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6301CFB6
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708936045; cv=none; b=P0Tr2jRK3yALa4cYDW8ccEfB1+wDCXNsmBv1FsnzX9SD+O7GjhnLyWrhqx2brStXyksIOJrZI0u2HvxlQm6V4KRTbdraABRrjf1uBVFW/18VhXW7fzSj4GOuu1Bs8TU8BczdccFIDL4l+2KKSav2/RJ1MUqGtsU8wFXBX55HQpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708936045; c=relaxed/simple;
	bh=wx7Iy2QJMe+2Uk0OWiLzNeXpjDn8dEwznplozsjBXCs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=FzD7EZF/szqWqH1Y6/SoOfB2P4fPtestStl60dGGb7s4cLxkqDEhp9rQs5BMD+rduRVd5BtBoF8yVFLSTWEkVkVH7PdnFc2PdIihCne6Q/bVZPlsZeE4rpS2fZqh1S43yX/atN7dK25k4tWK0MBqTcNT9IbX1QsE4ms1J1jHpGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=x3PaDZ7Q; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412a4848f0dso4622945e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 00:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1708936042; x=1709540842; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wx7Iy2QJMe+2Uk0OWiLzNeXpjDn8dEwznplozsjBXCs=;
        b=x3PaDZ7QtB4m/zCXWvpscIilmn6EVg2XbhQGm4SJVlStz+glkuoP3H76mZGx2TqtbE
         nONEOA0XlYCNlFfpy4DQ6OTzJm+xy+6chYnWw7O7F3IVjBsExw2epvIiBNq9Mbwtb1kE
         ewTTkVt58EcW28gHObTsAR8NX7DHWD9rOKk4q0ZXGphDL/8s1PDbJKRMSd9vVK/jpN5M
         mTLTnBRfWa7O9+LnbfBTMA/Q8lziMU7g+2y84LTeB+n7owzQfZlin0llc1m8GaRBFVn9
         2PqC2nVYokn/qhrI6Fmj1fhsAa1MXla8BesdKEhc967qcQG6lyZtc9x5WKckjS9vRB16
         r7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708936042; x=1709540842;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wx7Iy2QJMe+2Uk0OWiLzNeXpjDn8dEwznplozsjBXCs=;
        b=QOFRwwNNMJ3aRK5pAQbCzGeK+WGTWPSwz4bQlLfBeF9wCkdrvz06bXs0838iRN69vl
         1E7XEoj599UIlFFrPdzzYVxazqxDiM02tH0AOdqB3/V7S841swysxq8HIQnDKa0v/4dO
         ISN8sgD2tcY8yAhRPDbATUXLer9FrOBInZzK2jzgnTEZ3AVoHXelI6B54WCaGuPY0o+j
         hU43AT/9DU3iIM9h4cFf3MmT0shTuyXrfn9uFNFbXipnVwnDoCifEkMLDD3BlYUJzwD6
         2+4ycWWJk0w9iDNaxznNdLImR1QHkqQvwO/Hgst+n4fqcHWLvXsTBnNobkgG1mMg/5nu
         IJdQ==
X-Gm-Message-State: AOJu0YykOWY4oULuEsJrY1o5pVN4jET8dR0d4aAmXztnxkqADT7IFUSd
	vE/o6YxbYg0YhRSygvnLX0QLloCPO0gadcAm4hcKsKLBV1XVqfoNqaqp84S1pT0=
X-Google-Smtp-Source: AGHT+IHoWMzSCvO3a+H2o3ge/YDHBqqc9v5/SHY1pc/3OIM+oPW7Q50+vpl9j4bppFQa47wJfb9zWg==
X-Received: by 2002:a7b:cd99:0:b0:412:9804:d225 with SMTP id y25-20020a7bcd99000000b004129804d225mr5483161wmj.21.1708936041880;
        Mon, 26 Feb 2024 00:27:21 -0800 (PST)
Received: from smtpclient.apple ([2001:a61:1069:f701:4cd9:dca5:bf52:458e])
        by smtp.gmail.com with ESMTPSA id bv20-20020a0560001f1400b0033d73e1505bsm7535761wrb.18.2024.02.26.00.27.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Feb 2024 00:27:21 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH] time: Use div64_long() instead of do_div()
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <4bc9df7f-ea00-ad5e-02f0-d4cae6f005ad@huawei.com>
Date: Mon, 26 Feb 2024 09:27:18 +0100
Cc: linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 John Stultz <jstultz@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E2A9A6AE-84F4-4C86-80CA-CC0C480FD9A8@toblux.com>
References: <20240225232541.17659-2-thorsten.blum@toblux.com>
 <4bc9df7f-ea00-ad5e-02f0-d4cae6f005ad@huawei.com>
To: "Liao, Chang" <liaochang1@huawei.com>
X-Mailer: Apple Mail (2.3774.400.31)


> On Feb 26, 2024, at 04:28, Liao, Chang <liaochang1@huawei.com> wrote:
>=20
> I am considering using div64_ul() to calculate the result. as shift_hz =
is
> unsigned long, assume the sign bit of divisor cycles_per_tick never be =
set
> in this context,then div64_long() will do a extra sign extension for =
result.

Yes, div64_ul() is better and also removes the warning.

I'll submit a v2 shortly.

Thanks,
Thorsten=

