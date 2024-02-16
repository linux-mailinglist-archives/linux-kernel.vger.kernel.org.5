Return-Path: <linux-kernel+bounces-69395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7BC858867
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09BD71C235D7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8CC14830D;
	Fri, 16 Feb 2024 22:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="wF5Ows0i"
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B871468F4;
	Fri, 16 Feb 2024 22:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.103.80.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708121439; cv=none; b=jQiwh8Fc4DW+U088svM4cMheG06qVz/Ak7Wj9JLy296fhUdB14ZlWhzARsRcYViR9Hp/qqTmsUEQhDAt2CmIzfZ143BClHRJYoaXD1xib0CRdL0DBFoqx+wg3N34nNouqMzUFm5NRk6ufmrVUsIEhOdOqq5e3cyTdwI0bMb2HKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708121439; c=relaxed/simple;
	bh=/sHZUn/XAwNS125EErNta5TM4Zds8ZmJ65gZ+Q3h5Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Zkjzw7/oUR0qJR4Efu3sq0YGYAWDZEBpBh4ryQKedUMDEhqII8MdXBbCQmiSmkhinYbweufy/tV/I3lw58P7b1fRVaakDIkUoYnGg35fJ3udIyEFA1TYNK6Dz5B7J2zCGp93bycsdxwRMp1RY5Pscqi4YONULkkHfPxGLm2uOg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it; spf=pass smtp.mailfrom=vaga.pv.it; dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b=wF5Ows0i; arc=none smtp.client-ip=212.103.80.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaga.pv.it
Received: from localhost (unknown [127.0.0.1])
	by mx.kolabnow.com (Postfix) with ESMTP id C1A3D2095C2B;
	Fri, 16 Feb 2024 23:10:27 +0100 (CET)
Authentication-Results: ext-mx-out011.mykolab.com (amavis);
 dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
 header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
	in-reply-to:content-disposition:content-type:content-type
	:mime-version:message-id:subject:subject:from:from:date:date
	:received:received:received; s=dkim20160331; t=1708121426; x=
	1709935827; bh=xuxrpYY0iWD0Zd2UtKI2bE2ueb3gq7tcisj5wWW8amg=; b=w
	F5Ows0irSNnOd0O5+CHtAiFzk+lwXyY0HTzOLgWteK9KLZVxNJ4gRPJ0+Yx6rb4u
	YwwKU/xljJ76Rh0pTbmwccqkgtOwgmPdjUTarja9qyR/CBWjoWcxqbQ7zxDd4Xw5
	Kuq4uxfP5+zCHZBLs0LL5HK+NBNVZa7/nQBRtMGwIYK5nT64gxrP3KDeBEVKnCZI
	HA+N0xMEtY0Bn1OaP7V6Ttc3D8J/ZfUQSSMbqQSTwYlVArBXPZF6mD4T3iDtcteT
	EC/kp3uwyHQgLR7ozd2V54VULjZCEe7+iof79CnjuJY4MgwniUMJm8oVgHzRfWAy
	1nZDHHfEiep9H0xw2GOIDkOLsq+T+U17GLufNwcOEMVqzx5m+qjC6aOLuo2qAJUI
	2tWyoENKPIFUCLQIi+0Rj9PcseYbHDkEbk55laeh+l+frKytR5NPlOYXvuiR7xY9
	AueViFsP9gr57bX0hF7vj814kFSaLnJ8F4RmBWOOTwVpZWPccwPvgwu8ht+AX92L
	IRgd8756HizopaIHOXek/Wlh6owEQbvk8a73vBPUCMfO+AretAdC3u59JDoKKusQ
	qjNb4CmHHAsXRi/POlKg0MDAJJv0vQr6utegyw0+6Fdd0/K5a9t5aGMSoIMlWQiE
	QHFeGur9lg8glyBQ2DL2Z738cVrN8zFO6z/8n/3QRk=
X-Virus-Scanned: amavis at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level:
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out011.mykolab.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id di_rhQ4buexV; Fri, 16 Feb 2024 23:10:26 +0100 (CET)
Received: from int-mx011.mykolab.com (unknown [10.9.13.11])
	by mx.kolabnow.com (Postfix) with ESMTPS id 3433E2095C2A;
	Fri, 16 Feb 2024 23:10:26 +0100 (CET)
Received: from ext-subm010.mykolab.com (unknown [10.9.6.10])
	by int-mx011.mykolab.com (Postfix) with ESMTPS id E929930B2B99;
	Fri, 16 Feb 2024 23:10:25 +0100 (CET)
Date: Fri, 16 Feb 2024 23:10:24 +0100
From: Federico Vaga <federico.vaga@vaga.pv.it>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: it_IT: remove references to original documents
Message-ID: <20240216221024.7oqlosmy5yemqum4@numero-86.vaga.pv.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <fd73a8b4-c13d-4469-86ad-1ca6a0953c16@gmail.com>

Hello Akira,

On Fri, Feb 16, 2024 at 11:15:12AM +0900, Akira Yokosawa wrote:
>On Thu, 15 Feb 2024 22:45:46 +0100, Federico Vaga wrote:
>> A relatively recent improvement to the document building process added a
>> functionality to point to documents in different languages. Hence, it is
>> not necessary to add an explicit link to the main English page.
>
>It might be true as far as htmldocs is concerned, but please remember
>there are other targets such as latexdocs, epubdocs, etc., where the
>translations extension has no effect.

You are peferctly right. However, I do not see a significant value in these
references if they are not hyperlinks in a browser.

The reader of a translation might use the reference I'm removing in this patch
to quickly access the original document. But in theory it should come back once
clarified the doubts. (Otherwise there is no point in reading a translation if
then you stay on another language)

This easy way to go back and forth is offered only by using a web browser.

>That said, you are the maintainer of Italian pages.  I wouldn't complain
>if you ignore the other targets and go forward.
>
>Regards,
>Akira
>
>>
>> This patch removes those references
>>
>> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
>

-- 
Federico Vaga

