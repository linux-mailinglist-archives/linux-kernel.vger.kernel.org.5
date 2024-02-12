Return-Path: <linux-kernel+bounces-61288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9F2851066
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4011E28772C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D09617C6B;
	Mon, 12 Feb 2024 10:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ZRN6ozgc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s1SxU89p"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94CF5244
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707732893; cv=none; b=mypHi00ZUhgkYCthr+LZm2FSW13G3ePtRjIiWoCe74RdrXWhI1ySOnDNk9VSbYHMIfCBkutOjHibH6i77lmw3l0oeeWRFrA86VZuIfnKNfG5huF3YILB3+6f6oZLq84OwrlM7rLVNUN/dqInP1TlBo8O4ZAJxGRayPcPVvUcJsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707732893; c=relaxed/simple;
	bh=J/Kgk7VX3+VSNcQMqMb5LEduN+6QTHJfdTAZOt6yfA8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Xny+MF5fX7sbb6ZR2xHC1sZiyzyqQc7M1e5OvwUTDT8l7IXyeYY9WSv2l1FN+S69kGMO6ZSrkkCLLJqHGenqtJ5u3ERvR66K/U+PrjXIJrVFHxe5ACpytrmX4wescQiXKPAaR4QaKPJmQucMWKCMpt+yFpXvmWyj+ptW5FMP4Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ZRN6ozgc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s1SxU89p; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id A7E595C0096;
	Mon, 12 Feb 2024 05:14:49 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 12 Feb 2024 05:14:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707732889; x=1707819289; bh=G6CjnMK957
	IM+RCvtCLAx+cGU8Pb8iQvHeoRYF4Gt58=; b=ZRN6ozgc7da8Hp6bwx7dNDKIUR
	arDYzFtVJHQIvDGtnZFpd+T9bN1R/eTSqIDT33lm6crGuGtqnlcVjBNBiMpfuVo/
	A1v5vS4WESxjlCSMZQVr+mVs3kppd5TRMTuOraRtUNfMcbxgLi0XnRyLjuOKatHu
	NxRBke3fijhKK+vWHXV66cGV339RygNAOFeAbW7ip0b7gbQsYzrf15cSb+Zjz2vk
	gUaYBn5dZP5+8c2b0KUhOjsSxfE63PHUueRnRtSHWHkHsO0sEPIvmjs06YIN9mt9
	nFwh1MBAQyITjHudMvXjWa1/bRRV34PLMO0TwtBw/4JBHdYZmoUPWofuSpNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707732889; x=1707819289; bh=G6CjnMK957IM+RCvtCLAx+cGU8Pb
	8iQvHeoRYF4Gt58=; b=s1SxU89p+fDvqV0388Bhw6l7c8xzfqXQN01N65eys0FM
	11A3pLBqI67ap+7BmkNdHYeIJPZF34ZN2ERA5I3TVaES09+ztCvtftyR9pMj7r2/
	KJahuw13wb5NIMh2GGkiSpoXWIij4ikxxq1pQ4BxGD7hDflH/Rwi0vuYvZF+JT8a
	dVdxehEdg3C7wcaXvptMIX7vIOHzmtlVALBVNxIfK8BJDRCfCDcCzn8J1yRHnVCr
	BHBeKSATpjX+SNlm6pXuJNY3p10s/dhF7R8Ip4i5ooKrafiCCQloaBZe79rd1QKz
	HfuaMmr6uyer/llKZXjbmbkUli5L4kZ+gANMLifaCA==
X-ME-Sender: <xms:me_JZaAKpiMbiKaVzf35qwxHo7rThEML0e_oZCqVb7LgOP0VbBdAfg>
    <xme:me_JZUhitC5w2Wn1iqF0jJLTTdsUnsGohX5a6G4uyOBHzKeLfrQ3GV08Pq5DvK6ui
    sETvA6SvwnFkiBno8E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:me_JZdng2vTKms-hK0Rj9ve1JcjaoCJdN2mDFtQW4snprBffjMGeyQ>
    <xmx:me_JZYweJKKELFUK4lTDubPgpzY6N7RF_0y74ykdtVvf4Er_hjmlmA>
    <xmx:me_JZfSNJkrgi1xnG3WzQMS3Nwqq5ZA_cEFSXMQZFS_le7y1Z006Yg>
    <xmx:me_JZdPIDzTZTYUZmmN9cR_oX5wvRurBcQTlSqSSBUGBErTrcyY97A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 51357B6008D; Mon, 12 Feb 2024 05:14:49 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d14e8a0c-f510-4c98-9bb6-1728eceb61aa@app.fastmail.com>
In-Reply-To: <2024021210-freeway-unblessed-d966@gregkh>
References: <20240212094618.344921-1-sakari.ailus@linux.intel.com>
 <20240212094618.344921-4-sakari.ailus@linux.intel.com>
 <2024021210-freeway-unblessed-d966@gregkh>
Date: Mon, 12 Feb 2024 11:14:29 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Sakari Ailus" <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, "Hans de Goede" <hdegoede@redhat.com>,
 "Tomas Winkler" <tomas.winkler@intel.com>,
 "Wentong Wu" <wentong.wu@intel.com>
Subject: Re: [PATCH 3/3] mei: vsc: Assign pinfo fields in variable declaration
Content-Type: text/plain

On Mon, Feb 12, 2024, at 11:02, Greg Kroah-Hartman wrote:
> On Mon, Feb 12, 2024 at 11:46:18AM +0200, Sakari Ailus wrote:
>> Assign all possible fields of pinfo in variable declaration, instead of
>> just zeroing it there.
>> 
>> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>> ---
>>  drivers/misc/mei/vsc-tp.c | 16 ++++++++--------
>>  1 file changed, 8 insertions(+), 8 deletions(-)
>> 
>> diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
>> index 200af14490d7..1eda2860f63b 100644
>> --- a/drivers/misc/mei/vsc-tp.c
>> +++ b/drivers/misc/mei/vsc-tp.c
>> @@ -447,11 +447,16 @@ static int vsc_tp_match_any(struct acpi_device *adev, void *data)
>>  
>>  static int vsc_tp_probe(struct spi_device *spi)
>>  {
>> -	struct platform_device_info pinfo = { 0 };
>> +	struct vsc_tp *tp;
>> +	struct platform_device_info pinfo = {
>> +		.name = "intel_vsc",
>> +		.data = &tp,
>> +		.size_data = sizeof(tp),
>> +		.id = PLATFORM_DEVID_NONE,
>> +	};
>
> But now you have potential stack data in the structure for the fields
> that you aren't assigning here, right?  Is that acceptable, or will it
> leak somewhere?
>
> This is why we generally do not do this type of style.  So unless you
> are fixing an issue here, please don't do it.

If you have any initializer, all named fields in the structure
are zeroed. The only bits of the structure that may contain
stack data are for padding between fields, but that doesn't
actually change here from the previous version.

The old version you have here just skips the named fields
and otherwise would end up lookingn like

struct platform_device_info pinfo = {
      .parent = 0,
};

which is still a partial initializer and has the added
problem of relying on a literal '0' as a NULL pointer.
In modern compilers, one can write this as
struct platform_device_info pinfo = {}, but Sakari's
version looks best to me.

     Arnd

