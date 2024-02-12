Return-Path: <linux-kernel+bounces-61098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 360D3850D3F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 05:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D311F2576F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 04:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8032B46A4;
	Mon, 12 Feb 2024 04:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RkROSJQn"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CE979C0;
	Mon, 12 Feb 2024 04:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707712608; cv=none; b=W+xM60acnlzD0wEyzyO4LbDPpJkXhyWn/Az4RTBIqqNxGbqosJvmzMZIz1nVwvdEhfiCp05kBE/lU9ZizHjsPf5N3vJXw9F3VIoHlIpKikStpxgdgcxT9Womn6GAH8g5kZGIZNV99XEcoWoYKxXz2RKG2KnKKiRATQkTy9AvpTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707712608; c=relaxed/simple;
	bh=0LdfwuXEgvUuy96j1v+0E60cIj1z0yxVc1lMVvSOjng=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SRRMRY7mo9ird8gACHKQAOgjlxtRawHkiVvncSUXJG+8BuqzJFt2K9SqTfg5bFxpeaGNIN7eFz8crfBVLK+jOTbo6sAn1VT9oFKO20L/9pPjrMZWy5ZxxHTH9hPJ1kW69f2Zgy+/jgdIYEyh0wzA/h1R8oX+qC5ZvU4VSrvnbdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RkROSJQn; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41C4aZph042290;
	Sun, 11 Feb 2024 22:36:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707712595;
	bh=dDe2x2/sNsxxovWiqiXQgtSK6CZ2bkfH7mRKphacIVw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=RkROSJQnh61KCNT0f5C5CL8FiFvbIU5XYMyiXUtxqmgenmaHyb4p8OoBkikUwmSNP
	 KKePU1FCmTSgSozuOBINuIV/x7BOCXnlIiJRbdBbLq8FeQ8lQvjJ7YYJbox+coP6LO
	 9QEe551QcM5EO9nwSYfiro5NQm4m6RNDuS1LUia0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41C4aZ44083637
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 11 Feb 2024 22:36:35 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 11
 Feb 2024 22:36:35 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 11 Feb 2024 22:36:35 -0600
Received: from [172.24.20.156] (lt5cd2489kgj.dhcp.ti.com [172.24.20.156])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41C4aVAh000720;
	Sun, 11 Feb 2024 22:36:31 -0600
Message-ID: <b27ea51f-ad29-4c8a-8f33-f51640f0c013@ti.com>
Date: Mon, 12 Feb 2024 10:06:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] clk: keystone: sci-clk: Adding support for non
 contiguous clocks
Content-Language: en-US
To: Francesco Dolcini <francesco@dolcini.it>
CC: <nm@ti.com>, <kristo@kernel.org>, <ssantosh@kernel.org>, <chandru@ti.com>,
        <rishabh@ti.com>, <kamlesh@ti.com>, <vigneshr@ti.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
References: <20240207091100.4001428-1-u-kumar1@ti.com>
 <20240211155459.GA4443@francesco-nb>
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240211155459.GA4443@francesco-nb>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 2/11/2024 9:24 PM, Francesco Dolcini wrote:
> On Wed, Feb 07, 2024 at 02:41:00PM +0530, Udit Kumar wrote:
>> Most of clocks and their parents are defined in contiguous range,
>> But in few cases, there is gap in clock numbers[0].
>> Driver assumes clocks to be in contiguous range, and add their clock
>> ids incrementally.
>>
>> New firmware started returning error while calling get_freq and is_on
>> API for non-available clock ids.
>>
>> In this fix, driver checks and adds only valid clock ids.
>>
>> Fixes: 3c13933c6033 ("clk: keystone: sci-clk: add support for dynamically probing clocks")
>>
>> [0] https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j7200/clocks.html
>> Section Clocks for NAVSS0_CPTS_0 Device,
>> clock id 12-15 not present.
>>
>> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> no empty lines in between tags and only tags at the end of the commit
> message, this [0] reference needs to be before or moved to a `Link:` tag,
> whatever works best for you.


Thanks

will below works ?

[0]https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j7200/clocks.html
Section Clocks for NAVSS0_CPTS_0 Device,
clock id 12-15 not present
Fixes: 3c13933c6033 ("clk: keystone: sci-clk: add support for 
dynamically probing clocks")


Udit


