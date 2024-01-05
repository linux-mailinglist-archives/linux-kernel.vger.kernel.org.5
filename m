Return-Path: <linux-kernel+bounces-17398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E371824CA6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C471C229C1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 01:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF131FD1;
	Fri,  5 Jan 2024 01:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXIscpV/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1301FA3;
	Fri,  5 Jan 2024 01:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5f3a5b9e09cso2754237b3.0;
        Thu, 04 Jan 2024 17:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704419387; x=1705024187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EgeaXJc1BAQQwhIsnnUkEVIzKQJLyZHFHdN0kJVCdXo=;
        b=KXIscpV/Sbu2T5DnfETKnP7EXhn14upnjGh3mSBTcNAM8Ud9PNwUWNIO/6rtjn8seG
         Jnt9wvwwTj9uJcDOIrM7A9/81+PMX6dBxeAP5ihAIsNKh9hOhEI7CohECfXW6u4OTIyP
         ET35n4BS9I2o6D552ShvGeUItOAqEpZecMZf9ON+eo5L6iq6beqZoqi+a85vCFK0R6zo
         h0fpl9EdqUyQdJ3JYEb/VRG7RPSyhFqjUUPlH2KqE6EYB5yPzE9EwrxNuqwSUj2ahO5U
         nKKxOIfBlNnqcZkBJC9SozbjL2inxQKvn9obfj8lX5x55a5kS/njvdEb9e0OyhgTziMc
         9GgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704419387; x=1705024187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgeaXJc1BAQQwhIsnnUkEVIzKQJLyZHFHdN0kJVCdXo=;
        b=NwWN1bbeyqJ911VlN3fyxng1MsNfG07zOvUfDjNIFvLdbbpKGM+kTOELM0MuzkemkW
         +6g3rRrIVgZ1VX5kosdyVDfUSTCKrAYptB5Qn7qNbhkDrBGlDftysrb4nIFeo1iSK9CP
         yoml7MeqP++vgXQ2531gHIDk/D8di2YIW41dKHuQOQSH55fzETSiN0zFwVMFQpd/15Qo
         elPk0C0MbROHuJIMd3BV/9ZuB9mP0bhGxkXbkvaIA+Bx7f5TAMTUoSO5eML3OTaQFHMc
         yNss3H2xRbEM4nCkUkarQ/3AxO3/kcWvH8QoloGV0nCDI0WTOEVwJD/VV9sMdAnKG/he
         KdPA==
X-Gm-Message-State: AOJu0YxvcTpkDdCo4qCbaLE3vLLQ5b/RfDYSMIiJAfrRLe2ybtlS62JZ
	vpdZTHVdmbmjzGG3EbAey9w=
X-Google-Smtp-Source: AGHT+IGziUfJwgFJObYRK8k1/dWNtcbmiI9iEoSrXnDyE8D1BhwChyjS/1WaeTOTK7Hy86bxYQ/2Iw==
X-Received: by 2002:a25:80d2:0:b0:dbe:9db9:d113 with SMTP id c18-20020a2580d2000000b00dbe9db9d113mr2141097ybm.5.1704419387650;
        Thu, 04 Jan 2024 17:49:47 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d2-20020a256802000000b00dbdaacb96bdsm164283ybc.12.2024.01.04.17.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 17:49:47 -0800 (PST)
Date: Thu, 4 Jan 2024 17:49:45 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Min Li <lnimi@hotmail.com>
Cc: lee@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v6 1/2] ptp: introduce PTP_CLOCK_EXTOFF event
 for the measured external offset
Message-ID: <ZZdgOUmn2fzHMZwC@hoboy.vegasvil.org>
References: <PH7PR03MB7064CD80AD7DA745B3F6790FA0672@PH7PR03MB7064.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR03MB7064CD80AD7DA745B3F6790FA0672@PH7PR03MB7064.namprd03.prod.outlook.com>

On Thu, Jan 04, 2024 at 12:12:11PM -0500, Min Li wrote:
> From: Min Li <min.li.xe@renesas.com>
> 
> This change is for the PHC devices that can measure the phase offset
> between PHC signal and the external signal, such as the 1PPS signal of
> GNSS. Reporting PTP_CLOCK_EXTOFF to user space will be piggy-backed to
> the existing ptp_extts_event so that application such as ts2phc can
> poll the external offset the same way as extts. Hence, ts2phc can use
> the offset to achieve the alignment between PHC and the external signal
> by the help of either SW or HW filters.
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>

Acked-by: Richard Cochran <richardcochran@gmail.com>

