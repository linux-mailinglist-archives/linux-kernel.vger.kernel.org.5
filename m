Return-Path: <linux-kernel+bounces-123397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA198907EF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519151F266FA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F9E131E59;
	Thu, 28 Mar 2024 18:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFkxlUXh"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED169130AF3;
	Thu, 28 Mar 2024 18:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711649127; cv=none; b=Kk6d93hnLCsUM+CCAwXT+y/1eySxAh+sGnA9kkrr4528zQNhA918xNcwN32iUdu04m61lW6c+whCXgdT1g+4jGTiF3AeiaMc9D/MV5q5pLCBvSxHYBog3Htj20BVlm6TNGLPkVcjF6Kz+fnL2yZV2YMnuDseq2LyPXwDucWXcgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711649127; c=relaxed/simple;
	bh=aFSCjclxqeDyxNPG8CG1rNS3d6TVmOgwGEULmjQ33k8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCINsIeTAl39NpGA+TijMMmCu+jCkF/4zM4J7dGWW0qplc/WJV4oAWOuKAUP8sx9nn934ZZPx8x9Mor/QaegE6HfADlWmIxE2zXA2NmSF3scYSYRzJdQXOCvHPJat7Y94IU/Bf/H6WfqyIq0G+sx+rSbONi0tNxbUGe78VSvx+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFkxlUXh; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-368aa96233bso5540895ab.3;
        Thu, 28 Mar 2024 11:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711649125; x=1712253925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K/sacnz72CwRH0otyTGzert8z0sn/i0tise2f/EaGiQ=;
        b=AFkxlUXhxQ4uagL3m4z+FmOX9CseFAlOwucLW35YJaZf/EJMi8hhzcwx2VpwXmw1C3
         trAdlBcN5GPx/ozFJT8sZtaUApbZbSHhC8ePhdPq6XDazgUGOKyzlAuBzSbD5FRM2KGt
         haVSVcKwOQjfT1HDGUir495mYYEQAoVEVcLJ7vUheyaKlXnAjZ9bWUIulQi0lWn+v+zq
         S1v7U8A5gNzs7YE5TQDCViLGZzR68/Bt8ebWc+x3YrrVn1TdioG4G5j2BSrQhx8q7yx9
         3XgG4JqXyXk5q2eEKfJ0dGxithYdjpsy363HZhZdxwvCL//MqH2oxK2rpBcVJDNzf0Yk
         8hRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711649125; x=1712253925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/sacnz72CwRH0otyTGzert8z0sn/i0tise2f/EaGiQ=;
        b=o0CYd/bwSUdPN4o1uexWSleRIfc9q5UEr2MX2WgD/NV9CSDpuBv7etWvlfFqO28SKx
         CJaQr5kV/0tOjvec4gCl2Cq3QhdCIlcQqNri7RNZiyLQHKmubGjNeYHs/G+ydG29uMg2
         vSrwEHrtRNz3mYnPbPD6IOhwvQrNsAwZ8Bw3rL8TtxCZKBzTs7bJVSV0g7IcM8H3GJ3Y
         HZZcdvzbwFpl21UjRiqaVqDi5K8k+5YgYqPuNI/7suKeHQu5CCyCO3REziz8FVyrXHj6
         OYjnsdqHB1wBsS+QoVWe+YA9xMdV/KWmneM7+/uyWLNvzvOcmf9HWasB1WA6vnXxkHTY
         Epqg==
X-Forwarded-Encrypted: i=1; AJvYcCV1B6Bs8O5cZlPoI9K7J2zPJ9AKkHJwlpcpnZYmCNk7loELLLZABjDAhoUX/KpGsWfEw5uYwbiC0fdJd0fKHiNLJUdARnd6zCNm5JYqKhcqvKQg8w4dGnZbQkQtfh6K1OL9CSU=
X-Gm-Message-State: AOJu0Yx0fKem8S807OJLSSwlB8TXa163JQPv/WYVFyISZuS288YzJbIc
	DXpU/Vk/5Y+fNdCV+6mo1ggtDHhJMyzh3NWKl3AtZS1IzMGTcLfl
X-Google-Smtp-Source: AGHT+IFxenVy3Vpe40qXySr/FIX8Cmzlhc9MA4Bak20UWKfT1c1La/2Q3sNRmDFpNQjvs7U7sVA40g==
X-Received: by 2002:a92:d486:0:b0:368:a474:4410 with SMTP id p6-20020a92d486000000b00368a4744410mr4494143ilg.2.1711649124902;
        Thu, 28 Mar 2024 11:05:24 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:493e:82a3:49f9:d88])
        by smtp.gmail.com with ESMTPSA id a185-20020a6366c2000000b005dc88b232a5sm1593248pgc.26.2024.03.28.11.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 11:05:24 -0700 (PDT)
Date: Thu, 28 Mar 2024 11:05:22 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jason Andryuk <jandryuk@gmail.com>
Cc: linux-kernel@vger.kernel.org, Phillip Susi <phill@thesusis.net>,
	stable@vger.kernel.org,
	Mattijs Korpershoek <mkorpershoek@baylibre.com>,
	linux-input@vger.kernel.org,
	xen-devel <xen-devel@lists.xenproject.org>,
	Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v3] Input: xen-kbdfront - drop keys to shrink modalias
Message-ID: <ZgWxYvQH4A_Vh1i4@google.com>
References: <20231011193444.81254-1-jandryuk@gmail.com>
 <CAKf6xpuJe6Cza6bow3QxDGf1viu0kish7Y8YRN8haXL1oEF3HA@mail.gmail.com>
 <CAKf6xpv2oDpPB3wWh=Fz_ahDVgmvw2MSj_q3RYqQ8NG6km5Tuw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKf6xpv2oDpPB3wWh=Fz_ahDVgmvw2MSj_q3RYqQ8NG6km5Tuw@mail.gmail.com>

Hi Jason,

On Wed, Mar 20, 2024 at 01:42:27PM -0400, Jason Andryuk wrote:
> Hi Dmitry,
> 
> Do you have any feedback, or can you pick up this patch?  It solves a
> real issue affecting udev, which crashes the Debian installer and
> breaks the mouse for Gnome.
> 
> Or would you be okay if this patch went in via the Xen tree?

I'd rather not. Could you please ping me in 2 weeks on this. I promise
we find a solution before the next release.

Thanks.

-- 
Dmitry

