Return-Path: <linux-kernel+bounces-47404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFD1844D8A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E192B259A2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFE23B194;
	Wed, 31 Jan 2024 23:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5hG0CSS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE983A8DA;
	Wed, 31 Jan 2024 23:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706745580; cv=none; b=lV3yVKgZiAooncIt/GgnlTZzH2kZkJHaRulWDKT15Au7uXwRWIpgGplfxfNvzSsoHmVxt1gZvqRjdlW3UyuN3VRqU2e9Y9ZBVrEDksQi1XPv0HPo2nKubpwHA0fuJoSl+Q2Db6FEZ8xkkmCHd8oZ8oNz2MhnhrtWevbmolM9FJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706745580; c=relaxed/simple;
	bh=BqQioyDl6ZFsyJQQi44W0KmQtj2xwsLFchj24A3uE2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kn/2feCEndWtbEVmyez7NWV73k93BmxTHV6pmWQwnyFdQpGDYKhbohTtfh0Ma+z+dRnlhsC+LricpLLHMep9i+vceIhD70V2Icb9yMmTxhzlacjaX3dysXrtIt6HNnvB2zQprL3ECu5MuUlfAE4pCH/6su1b1gV8hKW/ws0kgZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5hG0CSS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12311C43390;
	Wed, 31 Jan 2024 23:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706745579;
	bh=BqQioyDl6ZFsyJQQi44W0KmQtj2xwsLFchj24A3uE2U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m5hG0CSSZS9PDVuqao99NoSzc8nXYfQ4NLyoPNJZk1VCfY09xGnTRbHuZPcptd3i/
	 lJWj8PGLo+7/NJuM25NJTxTSjRgUB+iwHko4ZoTbM4NMYOXnXjjKSxA4ylk54g60tu
	 ZIPHcC2nT/RZhrgDaluBdwt28J2Kh1IsokptEDNOZRbfjsp+Xfh+8wdHYTMAjm0mQO
	 dfLqIZQ0OYKphA5odW5GmtEx20atfN5AOZv06/5LGiR5hRmFJPAtCNyJWnty/F6g81
	 vSqU+qNBXbnvz1l/c9IGoirSy+qgKz+KQYAaF+9bi7vl8WyxyplOaxgZ6k53s2ED76
	 OqpgEAU6IgUMg==
Message-ID: <487ac3ad-2343-451b-a84e-153d0b01dee4@kernel.org>
Date: Thu, 1 Feb 2024 08:59:36 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] block: print warning when invalid domain set to
 ioprio
Content-Language: en-US
To: Zhaoyang Huang <huangzhaoyang@gmail.com>,
 Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Hannes Reinecke <hare@suse.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "steve.kang@unisoc.com" <steve.kang@unisoc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Bart Van Assche <bvanassche@acm.org>
References: <20240131121401.3898735-1-zhaoyang.huang@unisoc.com>
 <ZbpCo+90OsXJwFWV@x1-carbon> <ZbpGDFUGQoaRQWHq@x1-carbon>
 <CAGWkznGOjsA3eGRt4i-1XAt=39ce7vaN7=zciimLJOMg=HD7Zw@mail.gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CAGWkznGOjsA3eGRt4i-1XAt=39ce7vaN7=zciimLJOMg=HD7Zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/1/24 08:34, Zhaoyang Huang wrote:
> On Wed, Jan 31, 2024 at 9:07 PM Niklas Cassel <Niklas.Cassel@wdc.com> wrote:
>> This sound like either a bug in the FS or by some of your local changes
>> that you did for your other patch (ioprio based on activity).
> Yes. That's why I would like to suggest adding some information here
> to help developers find the clue quickly.

The backtrace was not clear enough ?

When a request reaches mq-deadline, the request priority is supposed to be
correct already. Your changes had a bug and broke that assumption. Please fix
that instead of adding error messages for errors that should never happen in the
first place.

-- 
Damien Le Moal
Western Digital Research


