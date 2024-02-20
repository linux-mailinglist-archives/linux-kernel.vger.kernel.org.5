Return-Path: <linux-kernel+bounces-72800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC8385B8C6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14592282A6E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF926166A;
	Tue, 20 Feb 2024 10:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="rY4E3A8w"
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38DD612C9;
	Tue, 20 Feb 2024 10:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.103.80.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708424175; cv=none; b=s5s1muvlBNqk/GHApSKzWqK9A6pQvVir0QvfkSBwmYmHLhS0PCxUxD29uLxkQlXSsm0BW87bqJiEtAjMqfyZIkkmiAFHWRy8B/xttTqSedrSOSlF2nF0fKutFlaSI3vP8Uq/0GZYWu1ip6F9dWs0aJmtzGMgfDjcBC5BxPMY1JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708424175; c=relaxed/simple;
	bh=ebJgbSNf9jMxE4ngy2YrW23vPePmKm/ao57ZtY0Pyk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8kLiQh6vJeCPkuiEN+Z24H12EMr0zjAHjJ6ky23s0q5PP3DcAeLZ6yBSXpuPGuS8so8JJGZvsbF/O5zQ+TsEz/e3SD0gQBMNBURHda+py3mHqEWLO65d/BxQ8AxodU9jDn8w1NrV762gxyX5eOV6BH3LRLj1au5tWKMEmfAJzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it; spf=pass smtp.mailfrom=vaga.pv.it; dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b=rY4E3A8w; arc=none smtp.client-ip=212.103.80.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaga.pv.it
Received: from localhost (unknown [127.0.0.1])
	by mx.kolabnow.com (Postfix) with ESMTP id 06C77304FB5A;
	Tue, 20 Feb 2024 11:16:04 +0100 (CET)
Authentication-Results: ext-mx-out013.mykolab.com (amavis);
 dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
 header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
	in-reply-to:content-disposition:content-type:content-type
	:mime-version:references:message-id:subject:subject:from:from
	:date:date:received:received:received; s=dkim20160331; t=
	1708424163; x=1710238564; bh=itgVTaLWr2bprK8das7AsKk4s28b7DmmIbz
	eOHvRYD8=; b=rY4E3A8wGeWEwaGVwNJDHPcqGRQ3sbNYysu37M6DrtnWUsn4eMM
	GTFjft9iv++dSnXssbwldShhnNdDryDvElkt+RU80wqBG5Pr/hjwR1/KfAWfmYZP
	92Jmzey035l3WYIIO079N42uKIVa8ok/7s1QGCZhUWa4vE4h/ydvTuZEmeeAY8dH
	86kxSlyEU8CJpGDvXn6E6stUhuqPUEerNqEyLcOX1uf5ZnoCNh6BpRDZOq7h0VX9
	Tby2OQPFk8Pj2mUbhw8A5/YLnB67PFwgdue52eWYLL10CWAMYQSJt6SJtsHhlX6R
	80b/p+9vzw4zuJNWVLb3iHLPhr0iyXqfQlV7epOzNdKcraEZvreOtYZQBZY6CSlh
	Yzdvl3/xfqom/dkruz7utZLxe1RTx72ItkeenO32qyIhO334ULIIMABma6v9LVCl
	B3LsUNpS3c8sL/XjBpHbBy3NxgvxIss4sLkZrmyE8Ii5VgIKEH+gRJBN92twHXpm
	WJIzs/5J+Yt/RdT9d53WswVB7HbWZJOKtMN2CxzgC44qUyTtsumvpMtc3Lbk2ubE
	B7qWKgyXOlPJl8lhW38ldTFYtGomPHX8XfLr611os6HwEH0atYsedpr2kd0U5qzz
	m6UKjS5nkpqBjdENBUnR5q7wFQGQ/67K/SSGZSxP567YzAcl4YSRspNs=
X-Virus-Scanned: amavis at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level:
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out013.mykolab.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id RRS_aQkFojmF; Tue, 20 Feb 2024 11:16:03 +0100 (CET)
Received: from int-mx009.mykolab.com (unknown [10.9.13.9])
	by mx.kolabnow.com (Postfix) with ESMTPS id 3BD19304FB56;
	Tue, 20 Feb 2024 11:16:02 +0100 (CET)
Received: from ext-subm010.mykolab.com (unknown [10.9.6.10])
	by int-mx009.mykolab.com (Postfix) with ESMTPS id AD8A820C7249;
	Tue, 20 Feb 2024 11:16:01 +0100 (CET)
Date: Tue, 20 Feb 2024 11:15:59 +0100
From: Federico Vaga <federico.vaga@vaga.pv.it>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Akira Yokosawa <akiyks@gmail.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: it_IT: remove references to original documents
Message-ID: <20240220101559.66mjzrdug5kmdf5z@number5.vaga.pv.it>
References: <20240216221024.7oqlosmy5yemqum4@numero-86.vaga.pv.it>
 <87h6i4nov6.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87h6i4nov6.fsf@meer.lwn.net>

On Mon, Feb 19, 2024 at 02:08:45PM -0700, Jonathan Corbet wrote:
>Remember, though, that we aim to keep the plain-text docs as readable as
>we possibly can; the translation extension isn't helpful there.
>
>My inclination would be to keep the references in place.  That said,
>you're in charge of the Italian translations; if you want to take them
>out I'll apply the patch.

Fine. Let's keep the reference around for plain text readers :)

-- 
Federico Vaga

