Return-Path: <linux-kernel+bounces-122043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEB588F122
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DF4C1F2E3A2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC57153588;
	Wed, 27 Mar 2024 21:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tryAY9MH"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3335F152DF0;
	Wed, 27 Mar 2024 21:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711575819; cv=none; b=kNPXEpJbIxs48a3BMvC9EpQevXGrQyAeHJhd9Jq5iJ8pmY496pvxmPBRsDMBxWl6yQnZ4BxZ0Dz3DPQJObzGScNTStLO0saapNKimmVmfcPyqqBpYFBL1Lw/uqUpZdobU8gkvU8KBKJCUqrlCaYHJTURl+R5JYcw/AnYNxl/Rvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711575819; c=relaxed/simple;
	bh=qXdwMjctvpeC4uhAfUKnHc6+D0VbmDFQ/tteFpiojL8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FVl/OdxyU5dlggAskj2cPvHt2/izWLVGO3sdqI+CxniNJcaosikk9fQunLa1p9WmckuUl8++5TeGlEizIalwRRHBQwKXl50HNjqOxwc3vTJ1kNiEJukpFsENyPyv/cOQCe6JM+e8+3djtXY0E9WJzkWWbl+8PEq1c37qpMn6O9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tryAY9MH; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=0E6XNCXe9tY4/BkqEg7TfJ6EdX6Zcqe7RrlA/oI/V+0=;
	t=1711575818; x=1712785418; b=tryAY9MHAsL65aVTGC72ATnxbgVWvoxRTkMcDUyA5oMd4cZ
	SVBkclQZ2SauBxQlT9ss9ZDk8kIx+MsCXgdwZuKt3Ns7wbiJIYN+RmhrlPmeOEXPCWdeFV5bqD63g
	2honUAjmUggIEDgLYb9+LRPXH6gKDH7/TQAj0Q0I7apFJ5DYlOdmRgtKElDjLgmkTTFmgXWBv2QnQ
	7FPrCaMI2JwTxrWNnQrvOx9Sk/2nEH57O/yeGOlgU5yEqE0E3qo3VGoX3BoIAgXs83nJrQMDf3erc
	iUnYUDWWOdadbD14oWFs+2ukGxfKJWxAh1H5Qt4mi3oUGw5etabr4XxmwfVPXPmg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpb3W-0000000HPjO-1ApD;
	Wed, 27 Mar 2024 22:43:34 +0100
Message-ID: <e6fabaa541704463804f48b5931e8a43f7ee75eb.camel@sipsolutions.net>
Subject: Re: [PATCH 0/3] using guard/__free in networking
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Peter Zijlstra
	 <peterz@infradead.org>, linux-kernel@vger.kernel.org
Date: Wed, 27 Mar 2024 22:43:33 +0100
In-Reply-To: <0e7af4cb0dc19be7cc0267256284a70ceb250b38.camel@sipsolutions.net>
References: <20240325223905.100979-5-johannes@sipsolutions.net>
	 <20240325190957.02d74258@kernel.org>
	 <8eeae19a0535bfe72f87ee8c74a15dd2e753c765.camel@sipsolutions.net>
	 <20240326073722.637e8504@kernel.org>
	 <0dc633a36a658b96f9ec98165e7db61a176c79e0.camel@sipsolutions.net>
	 <87h6grbevf.fsf@cloudflare.com>
	 <0e7af4cb0dc19be7cc0267256284a70ceb250b38.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-03-27 at 22:28 +0100, Johannes Berg wrote:
>=20
> +typedef struct class_##_name##_drop##_t {				\
> +	class_##_name##_t obj;						\
> +	void (*destructor)(struct class_##_name##_drop##_t *);		\
> +} class_##_name##_drop##_t;						\

No, I misread the compiler output, it does output a real destructor
function to push it into a stack variable with this...

So I guess it'd have to be

void my_something(my_t *my)
{
..
	named_guard(lock, mutex)(&my->mutex);
..
	if (foo)
		return -EINVAL; // automatically unlocks
..
	// no need for lock any more
	drop_guard(lock, mutex);
..
	// do other things now unlocked
}


instead, syntax-wise.


Which obviously simplifies the changes:


diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index c2d09bc4f976..cf39a4a3f56f 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -163,6 +163,12 @@ static inline class_##_name##_t class_##_name##ext##_c=
onstructor(_init_args) \
 #define guard(_name) \
 	CLASS(_name, __UNIQUE_ID(guard))
=20
+#define named_guard(_name, _class) \
+	CLASS(_class, _name)
+
+#define drop_guard(_name, _class) \
+	do { class_##_class##_destructor(&_name); _name =3D NULL; } while (0)
+
 #define __guard_ptr(_name) class_##_name##_lock_ptr
=20
 #define scoped_guard(_name, args...)					\


