Return-Path: <linux-kernel+bounces-92967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F06E08728C0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D3F41F21DB5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19034129A99;
	Tue,  5 Mar 2024 20:29:33 +0000 (UTC)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E919460;
	Tue,  5 Mar 2024 20:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709670572; cv=none; b=dkmgrFpjgKz4BieHfhuZfXrnjV5lQetWri6Tr0pBAFVOgcTG78FQWnxgbkK0Q/NS20AOVnImWcGj0yecNbagx+2cg6Qu6xeAA1gsp2tatCvJfG5gvyHKO4FX92MdyXfiX7pyK8IvR53741yE7eCPSxgFQi2gTLuW1id6MoQqeJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709670572; c=relaxed/simple;
	bh=brvODVjEdn52eqWJ/v1JIz12UyK9u+bcrt/sT4hHvuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KVwLMjK2QYYA3td9jUEq+SCwk12ywgz5KGRWjqhrkulqzK0nAlIXtumaFqzpGGoKC4bX9/3OZ8C4+lNKBdUj4nr5KHn2HK7pPNsC+7Yy1+KNR9pA4DBGwUy9PnwNoO+7F0vKEA1aDoeoK3T7phLbavJdORAMiI05V++JxoHXMmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-220ce420472so983701fac.1;
        Tue, 05 Mar 2024 12:29:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709670570; x=1710275370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=brvODVjEdn52eqWJ/v1JIz12UyK9u+bcrt/sT4hHvuY=;
        b=Neuz0n5JvgWquBXnYC4+sK7P2GBxmRaQKgJQ3DQn8du1j2sFG6jvwW7xyKzNfifFk/
         IK6JELoQyGzIUgtnaJW6YfI4/viJYKwWIAS2+N1Y4C1FSQLp5+PHJ4oPfrx5aj9Vmhic
         Xj0iC87eJerUpzFbJvV62rrBp6MLf/OLULlpmVG9hVrc2OMX/RBZqJnZSqQIkaZJZENg
         XUfElU1LHPxS2kaANMQWjNT6KsNCvN5VEavUdo2+cwoq+VslsAs0TOjkrZyE2sWoXcHr
         /rWQhjVdiZamPbfb43VHoDGpB5cG9wbSfEcmYKUc5qTSBYGp2sUxPb9jJSnmtAH9fK+Z
         0SqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXF9ScsZYJfa//Sv3IGHkcrbn482546dqa/rECnPXoEXdEUszv3WGOfH4dQHqlAgAr/gyxzc8S7uutB1qc6MUOp6w5QgaNd8FYEUsjm1meWCHpJlLaRdyAo31sOGPhvUpwbMKUw0CSocgAd31qUt50tr8UixuxKIOH7oEktBjrSrQ==
X-Gm-Message-State: AOJu0YyYM8MnFmP92NGuAtK75hJYSb+qbG1EuLP64p1NMR17ipPlJJ0P
	cbHgpoWB+pW65TzmZ2olcWAFu0ABKeJE/+EXA+SjvY7iXMVCmT/viQRCCHYwY6UtE+cCtZL6+o2
	1q0ag+osuUmdWiTKskF4MZtIYWIQ=
X-Google-Smtp-Source: AGHT+IGmKFCKHu18eVUen1zEspsGJ1M3dG2mdYaT4Jy1mAiZvNyLnluyaZR18TRRqouw19nNwzybIEzP14gA+7Pr5Vs=
X-Received: by 2002:a05:6870:d681:b0:21e:ad52:3029 with SMTP id
 z1-20020a056870d68100b0021ead523029mr1568208oap.0.1709670570363; Tue, 05 Mar
 2024 12:29:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301192600.2568-1-jarredwhite@linux.microsoft.com>
 <CAJZ5v0hTmkB_rrFgxUYbrxbs_JC-vM1oYdH27D-QvVaVuovNXg@mail.gmail.com> <5cd020bf-35a1-4ffc-bb32-167ac311d5d3@linux.microsoft.com>
In-Reply-To: <5cd020bf-35a1-4ffc-bb32-167ac311d5d3@linux.microsoft.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 5 Mar 2024 21:29:18 +0100
Message-ID: <CAJZ5v0j8hsp0XAWfgXRZwHAk+rRDRQwMGrureFRZgwHa3USbug@mail.gmail.com>
Subject: Re: [PATCH v3] acpi: Use access_width over bit_width for system
 memory accesses
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jarred White <jarredwhite@linux.microsoft.com>, 
	Len Brown <lenb@kernel.org>, "open list:ACPI" <linux-acpi@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, srivatsabhat@linux.microsoft.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 9:19=E2=80=AFPM Easwar Hariharan
<eahariha@linux.microsoft.com> wrote:
>
> On 3/5/2024 12:15 PM, Rafael J. Wysocki wrote:
>
> <snip>
> >
> > Applied as 6.9 material with some edits in the subject and changelog
> > and some adjustments of the new comments (one edited and one dropped).
> >
> > Thanks!
>
> Thank you, Rafael! Could you please add as well:
>
> Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

Added, thanks!

