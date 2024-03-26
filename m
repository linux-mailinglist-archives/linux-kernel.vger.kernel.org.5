Return-Path: <linux-kernel+bounces-118509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A81DC88BBED
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47B4F1F3783A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E6F137752;
	Tue, 26 Mar 2024 08:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNm+WJe1"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E1513281B;
	Tue, 26 Mar 2024 08:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711440364; cv=none; b=t1NpKhmjthALNYz9Wlrq14iG5RrUZ2ejh5OAZ4/UsRjK55yx0cwc0EcGMgQjA8+OhBu363SbeyUkva0a5KiLtsSahAKa+yhdpCCKd8BqtBLG7VpVRkRYY5qiLkpW+/edLytnMWtoErGq+Nn7nwlQbP2JjMR0+r6Ktm+TIlfji0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711440364; c=relaxed/simple;
	bh=1dN1iTrP3tohzWptA2T2MCP7DsVN09BO7E3gaSGoAqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YehMoALx3zncIQHsz68zSl/DfRgqDqc/lYApgvXJGX6g/uTkqXc6nxfbqcf9R0jdWrztZED/0VyzNvkbS0iV40LEDb50X/WjFlXW1BDXhv/982lx5lThCYDYj17lOL67P3vumBHE6Dvpxr+C82TJgGrjyCKKU7iQMwU5+uv7rIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNm+WJe1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4148c95db1fso5329265e9.0;
        Tue, 26 Mar 2024 01:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711440361; x=1712045161; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w08KEwD3ex9mJ/Il0J55afzxUV9OS7OdtKcY03XKYns=;
        b=TNm+WJe1MnGQ9O2oN7iVAfCudKv86KNvWZDIfm3dbwZzKNXPBryxlF+SZxIwdlVW0g
         u3En7TFkqGSrFBExBz0ejhBj2idWbZArEP3SW225WfC8N6D6qEwpBvZYyevzUL1VWPXl
         F3EkFds3rWF5aclCUFNv+PoX2TfGVm1sUFvsQmvptLRfk78Tk1QxEvI7CXSlE9VFvdvO
         vx+M1yBZtOUNuJYACCjwOqGS9FymKUfVz69dZ8gX/dPrRkc0sHCH8vd9w36q5PZjPMmF
         Hl8kL7S4EOTzFnJ/bIWziT/BNqrGJIRaRayld+X8XyiWAbplyrYnxevu8QggzHEZDTTr
         qcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711440361; x=1712045161;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w08KEwD3ex9mJ/Il0J55afzxUV9OS7OdtKcY03XKYns=;
        b=kz1px4VF5SS6bcqOyB03Fm1whw+w2kRYaVAXQPYnxsZSixJ4e7Jfp5uX24J3O0dqkS
         7XR/ADngBMyWtEFxiTWyqR9VXeMhrbJMUwCD3rR0re8IcMLL7flZ6HZW0UzyQKUHxOM7
         OFUWXVay+To/l5UTjnUF0qUPSX3RkcVLw5FCdi4rNvjug4Vh1ie1+UAyqOSKHw0gwqPJ
         DbW4ZDgXjgZCXuY/bGkjWQT3f2zN1xiKLSrDjRPrOizTzKye0PR79lim/BBQe0NwC5qS
         GbyNTrbhc4+TIirxhv67lFEKV9d/SzUGf83Gi1uzzEfwbtpy90ZqdnheYCnZbz0wWVBe
         qnrw==
X-Forwarded-Encrypted: i=1; AJvYcCXATkg0jqhDp7/e1MjbFcCjykG1dRy4/acbxauMcyyQFYn6dnqTh33TzGAio1yhCtoO8tdsdR6IPaOXBrXsTcOusnWzgKssXiNRnb10zCoNEHGAtIzb4O9OYe0BQJjuCfwwfpV3dW/j49kh+trpmA==
X-Gm-Message-State: AOJu0YzXMpEDBrl/DAxyw7hRuVVFOHdD8oeyVPQn6njmjQ4saMpFzMpE
	bHaY8ZaEp4NzeEJm7pwJlZgvOhgLzglftj31TrDVZdXPeItZEjHO
X-Google-Smtp-Source: AGHT+IFBVo6PBngS8dXsiIROlPjirz7Ab1EtZgBC4EtLcpirIq0EtNRX6T8YzXEW4GTDM8sy8Tg9Rw==
X-Received: by 2002:a05:600c:2807:b0:413:38ee:69e7 with SMTP id m7-20020a05600c280700b0041338ee69e7mr6443500wmb.36.1711440361185;
        Tue, 26 Mar 2024 01:06:01 -0700 (PDT)
Received: from gmail.com (1F2EF63C.nat.pool.telekom.hu. [31.46.246.60])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b004148c79f067sm2375333wmq.39.2024.03.26.01.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 01:06:00 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 26 Mar 2024 09:05:58 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Sandipan Das <sandipan.das@amd.com>
Cc: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, tglx@linutronix.de, bp@alien8.de,
	eranian@google.com, ravi.bangoria@amd.com, ananth.narayan@amd.com
Subject: Re: [PATCH 1/2] perf/x86/amd/core: Update stalled-cycles-* events
 for Zen 2 and later
Message-ID: <ZgKB5hMlt87E5VhI@gmail.com>
References: <cover.1711352180.git.sandipan.das@amd.com>
 <03d7fc8fa2a28f9be732116009025bdec1b3ec97.1711352180.git.sandipan.das@amd.com>
 <CAP-5=fVLWMnT4TV2nvbOUTTkWHYowbEOFDYqAvf1hkUEDpkKfw@mail.gmail.com>
 <5749c648-b6c4-4400-9628-3cd38d953f58@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5749c648-b6c4-4400-9628-3cd38d953f58@amd.com>


* Sandipan Das <sandipan.das@amd.com> wrote:

> On 3/25/2024 8:04 PM, Ian Rogers wrote:
> > On Mon, Mar 25, 2024 at 12:48 AM Sandipan Das <sandipan.das@amd.com> wrote:
> >>
> >> AMD processors based on Zen 2 and later microarchitectures do not
> >> support PMCx087 (instruction pipe stalls) which is used as the backing
> >> event for "stalled-cycles-frontend" and "stalled-cycles-backend". Use
> >> PMCx0A9 (cycles where micro-op queue is empty) instead to count frontend
> >> stalls and remove the entry for backend stalls since there is no direct
> >> replacement.
> >>
> >> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> > 
> > This looks good to me. Should there be a Fixes tag for the sake of backports?
> > 
> 
> My bad. Yes, there should a fixes tag.
> 
> Fixes: 3fe3331bb285 ("perf/x86/amd: Add event map for AMD Family 17h")
> 
> Ingo, I see that you have already pushed this to the perf/urgent branch.
> Should I send a v2?

That's OK, no need, I've amended the commits in perf/urgent. 2019 is quite 
a way back for a Fixes tag though. :-)

Thanks,

	Ingo

