Return-Path: <linux-kernel+bounces-39152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3CA83CB92
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120DF1F26CD8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17EE1339A3;
	Thu, 25 Jan 2024 18:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TedXx1kd"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A924777F02;
	Thu, 25 Jan 2024 18:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706208608; cv=none; b=TUSdW+8+JYZkw49vvlEUkr0hDVRjH5PsA3fmXzRBrBtlfVD1fNUrzkVPDqPgUFRfCCYimzWc5H5o5MkJYjWa0VDCrf1EebtDrPjQzdKp9ModQh6rjLvZkSZAKqAjAl9B5msYwcQa8MYEIFpVMyg+9AyGQPymSnWwgikVmP2fPUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706208608; c=relaxed/simple;
	bh=afkGmKH4gvXEOunY1EBCCvELTOJvIU3mOx1Et2oQDpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZQb5IfctoYIYmVndQAE3g2n67XXlilUNg9ubKI3UPg2EU2F3MqQ2xh1XrNMuZZpAquisf2pY0iG5wpNK6RIXyCOpJWpd5uvPl9cn/f5mPdOlG2gjE0F6NsKYEe884iWGH47WbDpHH/PCHRZKuJsiNjq6mFHOPPuGgvaul2+0Gt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TedXx1kd; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3106f5aac8so281516666b.0;
        Thu, 25 Jan 2024 10:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706208605; x=1706813405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afkGmKH4gvXEOunY1EBCCvELTOJvIU3mOx1Et2oQDpw=;
        b=TedXx1kd6YQ++4r6Au1CPZSDp2w15jw6y7uQ6olF5EvnYiq6QXk0iWt4CCSxHE8xLM
         8irKLamA4CdmdJ4bmGi3OGT+HIDN48/qD71IzA7IZNjsXuBHoRFxk2uY0wEilmg0xjEw
         8klJgzwZRoBszEDOluF4gdYKsHQKWEB/VzJlJ1hd/aF59fdym9QBBcbhzJmY1QhA1dbL
         +gqqsQV9j/r1VNdiqDMaCe02LMxGaycgxYqFb5YY3GLs1YrjT5NDthA/1Gi5pEo8sJQq
         BIfi3VtDMZr3TzR++EVIL8S/HD6rcLGTJSq84qtA5/QV5Tsjm6DdL6e4FnGZiZaGF4wL
         esSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706208605; x=1706813405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=afkGmKH4gvXEOunY1EBCCvELTOJvIU3mOx1Et2oQDpw=;
        b=DyKKFyOJnsc6EfnJNpbyOY0t3AA7s6AV21MH3DqECDOULzhPFSRxKfjrn5MtYn0Y8S
         REnYM+yI7H3Pn+CFsFJdZrxxLcy5MyIwgDRzy/c0dV3zEhIScncbNdNXydlkqYAu3rtd
         BUMpI6fl/Rr5ldHOM9MKDaA9fc0Tk8rlGjHtssANiF22gBqk5vhrR3PHnpc2hg46/cqJ
         NnlAzu/yJ4/sHWYvGz+qiRqYvmFmj/29ocVgwP6X8QIcAC5vpacEfN/hFUE9vhzelHYc
         684b9TRik8P0mi66KcNEbTN0VV9FMitL/lwEIpS+DiiHNvGO24YlkaZ1+DgkP49sm1jm
         evnA==
X-Gm-Message-State: AOJu0YxrpJYrYYMl0KeQQdk4hkEuTAP/GnTFhAKZ1MdVuSpTPRkwEdQ4
	QtfrzEmsDD+J+ttGpzSN6RD1PzWqVbsA+UzNbM6tfpeCrsB9R2lce4gN+bAexJnl1YLP2jaCLsu
	BnPWN2QjD+7du415CNrjD2ie3oWM=
X-Google-Smtp-Source: AGHT+IHOhBPlivb9GAqpT2fErL4B04Rn1Xzh6py69kWwJ6qbzbTTEteRYwwYvndRBTvZQW/iZKnNgbVXXTlQ0D7FcLc=
X-Received: by 2002:a17:906:5647:b0:a31:2324:1ff6 with SMTP id
 v7-20020a170906564700b00a3123241ff6mr17129ejr.111.1706208604747; Thu, 25 Jan
 2024 10:50:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125102555.2621736-1-ckeepax@opensource.cirrus.com> <20240125102555.2621736-4-ckeepax@opensource.cirrus.com>
In-Reply-To: <20240125102555.2621736-4-ckeepax@opensource.cirrus.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 25 Jan 2024 20:49:28 +0200
Message-ID: <CAHp75VcfM6U6ASGrDg_L+yJug_CDn_Q-DJ5RZeY9=Vn6hfOENA@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] mfd: cs42l43: Add time postfixes on defines
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lee@kernel.org, broonie@kernel.org, patches@opensource.cirrus.com, 
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 12:25=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:

Missed commit message creation?

> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

--=20
With Best Regards,
Andy Shevchenko

