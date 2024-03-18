Return-Path: <linux-kernel+bounces-105804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A1587E4C3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59B151F224CC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806CE28DA4;
	Mon, 18 Mar 2024 08:08:48 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E082575A;
	Mon, 18 Mar 2024 08:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710749328; cv=none; b=LSqThCEtWeP1VZjXGLIT5Gu3NDPH8hPF1jNi2fPYAA1NTVooIQZ4CKz+pn6PfMxUH+RDB3NzPZBOS1K9o0IYlJ5rzcZQkjWElp+7/U6Xb/UmWitDycJiwtHSRO9PE9Up0qHsHQycZ0junyIwu5ASHDTCPSAx1+AaA3jOtEZTwWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710749328; c=relaxed/simple;
	bh=Ap9vH7z4CybKmdoIokhNZ07YCPHW29bDiI3auayIwt0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SdblmGshp0M17wgPn3LJmZ2GvN+WIyKEOhdfEqB87rEW/QsbsSBt20T+odibXsM7zkSR6rPTyXdmUx5XsKvWAx+9wPI6+d8d6WGvf8/zlQuoB18yTIAoBJP4yx/YLuWW1BlTZVLO2sSqwS20IY2B6BoBSxE1+CPX15KkmhSgows=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Tyn681nmjz9xGWw;
	Mon, 18 Mar 2024 15:48:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 965CB14059E;
	Mon, 18 Mar 2024 16:08:28 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAnEydu9vdl4iuCBA--.40027S2;
	Mon, 18 Mar 2024 09:08:27 +0100 (CET)
Message-ID: <53a067f80db2e53ae29dc811515ab51c6ef86aed.camel@huaweicloud.com>
Subject: Re: [RFC PATCH v15 18/21] ipe: enable support for fs-verity as a
 trust provider
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Eric Biggers <ebiggers@kernel.org>, Fan Wu <wufan@linux.microsoft.com>
Cc: corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org,
 serge@hallyn.com,  tytso@mit.edu, axboe@kernel.dk, agk@redhat.com,
 snitzer@kernel.org,  eparis@redhat.com, paul@paul-moore.com,
 linux-doc@vger.kernel.org,  linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org,  fsverity@lists.linux.dev,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev, 
 audit@vger.kernel.org, linux-kernel@vger.kernel.org, Deven Bowers
 <deven.desai@linux.microsoft.com>
Date: Mon, 18 Mar 2024 09:08:10 +0100
In-Reply-To: <20240318051703.GB63337@sol.localdomain>
References: <1710560151-28904-1-git-send-email-wufan@linux.microsoft.com>
	 <1710560151-28904-19-git-send-email-wufan@linux.microsoft.com>
	 <20240318051703.GB63337@sol.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwAnEydu9vdl4iuCBA--.40027S2
X-Coremail-Antispam: 1UD129KBjvdXoWrur1xuFyfuFWDuFW8ZF4UCFg_yoWDXFX_ur
	Z5A34kXryvvF42vanIyr1qyrZrGwnrKF1UZ34avr4Y9343ZFZ3WaykC34kuFy7Ja129rZI
	9Fs8Zr1aqFWxujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb78YFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267
	AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU13rcDUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAGBF1jj5t93gAAsK

On Sun, 2024-03-17 at 22:17 -0700, Eric Biggers wrote:
> On Fri, Mar 15, 2024 at 08:35:48PM -0700, Fan Wu wrote:
> > +config IPE_PROP_FS_VERITY
> > +	bool "Enable property for fs-verity files"
> > +	depends on FS_VERITY && FS_VERITY_BUILTIN_SIGNATURES
> > +	help
> > +	  This option enables the usage of properties "fsverity_signature"
> > +	  and "fsverity_digest". These properties evaluate to TRUE when
> > +	  a file is fsverity enabled and with a signed digest
>=20
> Again: why would anyone care if there is a signature, if that signature i=
s not
> checked.
>=20
> I think you meant to write something like: "when a file is fsverity enabl=
ed and
> has a valid builtin signature whose signing cert is in the .fs-verity key=
ring".

I was also thinking the same. I didn't follow the recent development
closely, but unless IPE locks somehow the .fs-verity keyring, the
property you suggested would not be immutable. Meaning that someone can
add/remove a key in that keyring, making the property true or false.

Roberto


