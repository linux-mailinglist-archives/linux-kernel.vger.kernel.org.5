Return-Path: <linux-kernel+bounces-102776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EB887B72A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 05:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E028C1F22AC7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 04:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B447F79EE;
	Thu, 14 Mar 2024 04:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=post.com header.i=kolusion@post.com header.b="a0Ii887j"
Received: from mout.gmx.com (mout.gmx.com [74.208.4.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142E82F44
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 04:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710391610; cv=none; b=ac8sEs6MhKvPx5Eg8ymAlLKqgLoAv1xbfYyel3MRBBt9QkA42FCinmW8O+fK5wmWaAuwYS3xVH/50ddqRZCI/51hq+BDpbhJQ6IJ8+k2Zx4a4h5mm6Z5tZRbr7UEvU7eJSWwQgqcqklf5jiT1/QZ0CCj9zC6iLusICRIqydG40k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710391610; c=relaxed/simple;
	bh=i8aewbkj3bgU91cI4jY3s/QIOYe6q12c7yJ3VEQVYAM=;
	h=MIME-Version:Message-ID:From:To:Subject:Content-Type:Date; b=muT0I3Ov8ujmAJUAWvNAqx/w9MP5C3p2WVUtgtxDicL7RCs3WyA0kGyfLKDo6dtaPnG2sGynMrw8mP7q+YZONzkSI885YZTs+pFYTXx29kMIjdx6uJjG+05fZ4L4RIq4/VLwIEKDyut+RiOajg4aCyHiaCMbVr8c61reym671aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=post.com; spf=pass smtp.mailfrom=post.com; dkim=pass (2048-bit key) header.d=post.com header.i=kolusion@post.com header.b=a0Ii887j; arc=none smtp.client-ip=74.208.4.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=post.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=post.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=post.com;
	s=s1089575; t=1710391608; x=1710996408; i=kolusion@post.com;
	bh=i8aewbkj3bgU91cI4jY3s/QIOYe6q12c7yJ3VEQVYAM=;
	h=X-UI-Sender-Class:From:To:Subject:Date;
	b=a0Ii887ji/3yoZPJFU2bu+M4BWLrBP9RThJ1G3b3+xLLQNi72C8ubfB60Y5ZHq25
	 pYvUX7Z7FSTtWHqbOn8pwWye/QFht0EvKHaD6qBiwbX2o5vigB5rHliL0ZlcpFEbx
	 lgRpqa6K9fG3/pM4NLPEBmQVYgMedBdv8BO/dJmwbsuSeS9n4lLzLnMIgjme7stxJ
	 Z0O8DdH5rYPAmMFaRgwnvVxGLMJHP2wng6GyGwGF1yxOhYbmqADFoXSLQFfdjywyT
	 UCWmoUuz6Ub82+F38wN2rWjcNhplxfxYwCTtTURj/mH4hJgTalPQ6A3CUmuKoSBu1
	 fvWzhRiHFfsYxR2Zsw==
X-UI-Sender-Class: f2cb72be-343f-493d-8ec3-b1efb8d6185a
Received: from [10.237.67.4] ([10.237.67.4]) by msvc-mesg-gmxus001 (via
 HTTP); Thu, 14 Mar 2024 05:46:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-da135c23-2f1c-41c9-ba0c-17ee2d5cd035-1710391607967@msvc-mesg-gmxus001>
From: Kolusion K <kolusion@post.com>
To: linux-kernel@vger.kernel.org
Subject: Suggestion
Content-Type: text/plain; charset=UTF-8
Importance: normal
Sensitivity: Normal
Date: Thu, 14 Mar 2024 05:46:48 +0100
X-Priority: 3
X-Provags-ID: V03:K1:CligyEk/MGMu0LqHfLz1fevjVDohYRcJnXKWl+HevgsKWrDEpHZNZQ+yl7xg5L1wj+d5R
 ps/0HNRZQc5bQQCn6DAChJkLgeSEfM1SXPKQb2m9StD9lgx76qtpMphu55P54x0dXzy9VU5ZmYv/
 +6DIJaSSZiENWUUCYPmT3Q+QzNhfzARHFuOoZ20mtOD8Ocu4ugnNphE65V6L7j0y4rSmwc5MT78Y
 qDwAsFR9dmaD520AN3UlSN2rEbtUUOjecRqJuxil6u7UBgHhiw6ThGoQzt4onY0HgYdVztzOfKzE
 Pk=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hd8ZyqR2VKs=;kIYTNLZ7U/ps4ywZEgOjTa34BTt
 GBof0FS7wkQhSwJKks7igeHUJTBFNv7D7PLgr1jHekWF3dLoWy3B923KLj/KnTUBWFhwRzPFl
 1QUVT+eu0HZL2PFZOCkeUUvrpK22rqv8PHneb4NvH+ieXJvLI4VFRJR/MQ5carc5T/1IvhPn8
 V385Uc7rJFVNJSipFlo39m+i2kQlL2dSoTLGa1VnDL+2oK/q7TLuL871GJPvOnyxLUJOoZeQm
 +4vK7yfXPJtb6dAJE6RoFQPGO41abkNxCP/NkTvyN2mL1yDxCou7ndPJoxnQr1PcLZMIV6LsA
 1/0jpAkXp1gyGGy71HKF0+BxbvjvleFsNYBbEUGG/n/GTQ5UO8VXqOcEroj0/AjADzY2YAsaV
 iiwuANOoh8UgPCp0inFhKF9xmCqZ22ll+oTbj1d15ok8xHQON5zj/7NJn/kN1uNn/3hGfFEk1
 49iqQ3AULiWOjZ9CJ86wwP39TXCz4Kbno+tpPMGD3YabbSD61tpFChmIxWrmguEhs02C1h3qn
 r0t9w6GV9JoS9km82HkyTXuHuHfm9HVBtQ/F+yFWANvEdWOJ8gVByURxU4hKCgG2l6XlmqZtw
 8/4JSj6SKRdGDSwk1glZxV/elsZcDuNXfkBYiSF5q+AXBi0loeQTXcR0f3TIDY24J8fprl9dV
 GMkUivTFQpmpTGHcWMgyVC7UpawySYyGKWJOV5W3x39FaTOLQefE1tK50seDt6TwPWeqBg+vM
 Cqg20S1x5n4Hrj5/1dVB425ozSfBuS1XGGBKxT2EUvek6aR+JzCCy9wAWUz4ouEPMxMZ6vDZZ
 7K

Hello


Recently I have been fed up with all the low quality hobby software in the open source world and I have been wishing there was a true alternative open source operating system to Windows which doesn't suck. I had considered TempleOS but my games don't run on it. :)

This got me looking into the history of operating systems where I read MS-DOS was written in just 6 weeks.

Somehow I got onto looking at the Linux Standards Base and I was surprised at how well organised it is as well as how complex it is.

This got me thinking... With the amount of effort that went into creating the Linux Standard Base, that effort instead could have been used to create an official Linux userland etcetera and turn Linux into an operating system.

The world likes real operating systems. That's why MS-DOS dominated and why Windows continues to dominate, and why Microsoft is the worlds leading software developer. More people create applications for Windows than any other operating system and the applications are overall higher quality than applications for other operating systems.

My suggestion is instead of working on the Linux Standard Base, instead use that effort to create Linux into an actual operating system.

The world needs a true open source quality operating system that isn't just hobby software.


Sincerely,

Kolusion

