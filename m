Return-Path: <linux-kernel+bounces-49266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4688467F9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B08611C24750
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0048F17566;
	Fri,  2 Feb 2024 06:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="jiXaZG2Q";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="jiXaZG2Q"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B8A17541;
	Fri,  2 Feb 2024 06:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706855058; cv=none; b=d97+hvB0bEtdCa3FxR6V2JJeo3MVSgiKs1RdEvP7gbN+fKEm/Fka8wj6JwNZ/JIXbFR0yyIWXsDxBt5J6tymmuxseu7oddihnHVVa/uJGRfJy6mRoecVW6U14r6ePQhahbfKihs9C66eNrdj+DH8j9/jRKyHaLwj1ZDAfhGTF9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706855058; c=relaxed/simple;
	bh=fOB/2fCpXIXCroWTLb7l7CaHR+YkjmrDDQ/I3Kyx9bs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CehMmguXa/gcv9ikL6D+oHOJCn19yQceA8bpbzkJOpI0Cd2L80bAlKPGhLKuMQX0qPkbjue6dZfZu13FJDv94UVSVJSHSq6pCkYriX6Eop7qGRKKE0iUfAwhSM96+xV6CXw3HHAmVsAN2mBzAFNVJONGfYEtnwnjJDMsvph3j5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=jiXaZG2Q; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=jiXaZG2Q; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1706855054;
	bh=fOB/2fCpXIXCroWTLb7l7CaHR+YkjmrDDQ/I3Kyx9bs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=jiXaZG2QioWPL5nF2jJ+feRuh7JtSzvXZmSJNrtpl7d6GKS7H4/m6PeFj1I6Nlzlp
	 9wPcDMfax06VnV/FjrYTTyJaxlrI4iFgVLXWnYyKu5OcURmF1jGtqmBhBGiEZdDUl1
	 6NRhmqksvfqJpkBePXBICDJWODJplogtai4nXLBY=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id C882D1280604;
	Fri,  2 Feb 2024 01:24:14 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id OETKL_72TWtw; Fri,  2 Feb 2024 01:24:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1706855054;
	bh=fOB/2fCpXIXCroWTLb7l7CaHR+YkjmrDDQ/I3Kyx9bs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=jiXaZG2QioWPL5nF2jJ+feRuh7JtSzvXZmSJNrtpl7d6GKS7H4/m6PeFj1I6Nlzlp
	 9wPcDMfax06VnV/FjrYTTyJaxlrI4iFgVLXWnYyKu5OcURmF1jGtqmBhBGiEZdDUl1
	 6NRhmqksvfqJpkBePXBICDJWODJplogtai4nXLBY=
Received: from [172.22.1.109] (66.224-78-194.adsl-static.isp.belgacom.be [194.78.224.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 52F371280599;
	Fri,  2 Feb 2024 01:24:12 -0500 (EST)
Message-ID: <c17a31e4fb30f5f9d4a337e5bd8d54cc6f99eef7.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH v2 0/4] tsm: Runtime measurement registers ABI
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Samuel Ortiz <sameo@rivosinc.com>, Dan Williams
 <dan.j.williams@intel.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
  Qinkun Bao <qinkun@google.com>, "Yao, Jiewen" <jiewen.yao@intel.com>,
 "Xing, Cedric" <cedric.xing@intel.com>, Dionna Amalie Glaze
 <dionnaglaze@google.com>,  biao.lu@intel.com, linux-coco@lists.linux.dev,
 linux-integrity@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Fri, 02 Feb 2024 07:24:06 +0100
In-Reply-To: <20240128212532.2754325-1-sameo@rivosinc.com>
References: <20240128212532.2754325-1-sameo@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Sun, 2024-01-28 at 22:25 +0100, Samuel Ortiz wrote:
> All architectures supporting RTMRs expose a similar interface to
> their TVMs: An extension command/call that takes a measurement value
> and an RTMR index to extend it with, and a readback command for
> reading an RTMR value back (taking an RTMR index as an argument as
> well). This patch series builds an architecture agnostic, configfs-
> based ABI for userspace to extend and read RTMR values back. It
> extends the current TSM ops structure and each confidential computing
> architecture can implement this extension to provide RTMR support.

What's the actual use case for this?  At the moment the TPM PCRs only
provide a read interface to userspace (via /sys/class/tpm/tpmX/pcr-
shaY/Z) and don't have any extension ability becuase nothing in
userspace currently extends them.

The only current runtime use for TPM PCRs is IMA, which is in-kernel
(and which this patch doesn't enable).

Without the ability to log, this interface is unusable anyway, but even
with that it's not clear that you need the ability separately to extend
PCRs because the extension and log entry should be done atomically to
prevent the log going out of sync with the PCRs, so it would seem a log
first interface would be the correct way of doing this rather than a
PCR first one.

James


