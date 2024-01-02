Return-Path: <linux-kernel+bounces-14242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5696E8219C3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0A19B21B26
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345A8D2F0;
	Tue,  2 Jan 2024 10:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EKKewz7U"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBE6D534
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 10:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a27cc66d67eso200422666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 02:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1704191404; x=1704796204; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E5OnAk2HagspHkAF+udzNuli8uER3UpQGGb9ZBjsj8o=;
        b=EKKewz7UX4Z76Uk+C5Pg8dPTZ7pmk4a53H1ELfBMiz50XA6JHS5vAL3Q40NXFh5bHC
         1xMb/Vnj3V4ypYbfh+iG2hBI5Q+ldlk04ERGbNyInuqa4AZQ8p9cS+/8dRdQpwtHdag8
         9DGwicXE3E7l2BB5hlLGIoMILZCstu0oZrwsn+JmCJlJOniJ8f8VuOQJNSuvqvWuz9Y2
         C+8CJEUDCnlG8WG1lOBRFmkxmhK2PRLV112xXYScA+X0Rr03WUhwOu0auY1UqdJfs2ly
         hZyyYiXcKZQyq8uaqp561pLKjzVEDnlX4ot+ZktWCk4NTlGsay7aAAkaRH44S9y4i4+q
         /azQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704191404; x=1704796204;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5OnAk2HagspHkAF+udzNuli8uER3UpQGGb9ZBjsj8o=;
        b=c3W59+T0aZgI6Agnh4qd65TMiLjbUmt+KHsSm1olaAxqJeIM9xXbL0U5adqibs0RiI
         QwAtmQJ2CXUCprCK9SwYCYAAsbDa5+lnsPF0AoBHIOPhL42LGh9ME8+Wi67VO6qRJzRw
         SkTRKQGFp3b14pY/u7TeQTF9OpN+sGi/KyiN7PESpwBUZN0OXskw2/ksQ1jDTkj6TOd/
         ZqZXqYp2h99hcZeOytbVCtd+zRUJoRiFBS/orI+gSq0Org0+VfDmkukb3vRnKjmS7Kle
         x8CMsQ9DMd9oVdrIpjGVfEjKEmcA0H+sU7thZaA7Huk8VQt9u2hzHMTViY3oB7UChqyc
         rIHg==
X-Gm-Message-State: AOJu0YwQ2C6L+LrD2+F1Xk0tsO0fz4dLaM4ov1oDn9rGw9PWSDMPZa4u
	sVZHu8K8PgbomzAT9vync4ypWwKnDcgPVQ==
X-Google-Smtp-Source: AGHT+IEXMA4fFMbDZYS+N6y5Kmz/iEV+EfBUdhBol5W6atC5vGMu4WOubKgeb/63OlnWpAXb/eqWZw==
X-Received: by 2002:a17:906:2c45:b0:a27:ab99:dced with SMTP id f5-20020a1709062c4500b00a27ab99dcedmr2661820ejh.20.1704191403985;
        Tue, 02 Jan 2024 02:30:03 -0800 (PST)
Received: from localhost (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id gi29-20020a1709070c9d00b00a27c87be71asm2830450ejc.5.2024.01.02.02.30.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jan 2024 02:30:03 -0800 (PST)
From: Jiri Kosina <jkosina@suse.com>
X-Google-Original-From: Jiri Kosina <jikos@kernel.org>
Date: Tue, 2 Jan 2024 11:30:05 +0100 (CET)
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org, 
    linux-input@vger.kernel.org
Subject: Re: [PATCH 1/3] HID: make hid_bus_type const
In-Reply-To: <2023122045-pellet-eggbeater-8d2f@gregkh>
Message-ID: <nycvar.YFH.7.76.2401021129490.29548@cbobk.fhfr.pm>
References: <2023122045-pellet-eggbeater-8d2f@gregkh>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 20 Dec 2023, Greg Kroah-Hartman wrote:

> Now that the driver core can properly handle constant struct bus_type,
> move the hid_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.

I have applied all three patches to hid.git now. Thanks,

-- 
Jiri Kosina
SUSE Labs


