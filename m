Return-Path: <linux-kernel+bounces-147867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 381048A7ABE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E242B1F2205F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4616FB9;
	Wed, 17 Apr 2024 02:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LA57phaG"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED8E187F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 02:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713322245; cv=none; b=evn8SFpI+9mfrZQY5A8Hwr3HAe0lQFzbZ+HQ+P5wvoEICqXogv9UTJ46exbkDO6FZc/iqDL0GoQm2mvFCuokTQigBCffbaJDXayPVMfpq4/LEaB3ga0lm33lStu5aVOXocRVCZKLRuhCtlY1pwaf0IJA/09VkZqqLqqDdja2whQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713322245; c=relaxed/simple;
	bh=/FDO3Uw9+p8ydkHOVunFPN9wYZTRJmeTTdMPpt00iKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KNkXMGFq++jhvhHyDhuMSZxc4Gk7alK1fHuYp2DesjD/Z20QZ9YLWC4U31DF19VYS+zrkS28ORzYQlj61GDHJg4+qTa3QSqG0D6n9fe1h/inJxP5Trihey5xTIOrIh141GHX94dJ1nsCD+lf267oPNVirjqpWEraX6QcOPQWrJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LA57phaG; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <66ecea56-e4d3-4241-a1dc-378d70555321@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713322240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a/rtQZtLs/mz2eWV/Bg/16BoPls0vGnu3jMo7OCv9/g=;
	b=LA57phaG9cFvsxw3USySWeg4HYSn9eWdLVuJ1mszLR880/JyyNEt5h+5hPE6Me34Qqh19u
	Fac801LkcsF623K4yvXzi7yw9LoWNA3U258CUKSDGNDYb+aAUqy1tDPkBMFDPcUoxMvRr9
	WJqt/xQjGc9EypiYyhhDlhdn9fdHkPQ=
Date: Wed, 17 Apr 2024 10:50:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bcachefs: Align the display format of
 `btrees/inodes/keys`
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
 Youling Tang <tangyouling@kylinos.cn>
References: <20240417015448.84294-1-youling.tang@linux.dev>
 <toosz4pt2la6wf2575vwe6efebcbzsy735cq7exmlqhzrgicrf@s7g3rrbvge2l>
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <toosz4pt2la6wf2575vwe6efebcbzsy735cq7exmlqhzrgicrf@s7g3rrbvge2l>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi, Kent
On 17/04/2024 10:20, Kent Overstreet wrote:
> On Wed, Apr 17, 2024 at 09:54:48AM +0800, Youling Tang wrote:
>> From: Youling Tang <tangyouling@kylinos.cn>
>>
>> Before patch:
>> ```
>>   #cat btrees/inodes/keys
>>   u64s 17 type inode_v3 0:4096:U32_MAX len 0 ver 0:   mode=40755
>>     flags= (16300000)
>> ```
>>
>> After patch:
>> ```
>>   #cat btrees/inodes/keys
>>   u64s 17 type inode_v3 0:4096:U32_MAX len 0 ver 0:
>>     mode=40755
>>     flags= (16300000)
> This would print a newline for keys that don't have a value...
The original intention was to make the display of the printed content in
'__bch2_inode_unpacked_to_text ()' consistent, without considering other 
callbacks.

Or just modify it in the following way?
--- a/fs/bcachefs/inode.c
+++ b/fs/bcachefs/inode.c
@@ -534,6 +534,8 @@ int bch2_inode_v3_invalid(struct bch_fs *c, struct 
bkey_s_c k,
  static void __bch2_inode_unpacked_to_text(struct printbuf *out,
struct bch_inode_unpacked *inode)
  {
+       prt_newline(out);
+
         printbuf_indent_add(out, 2);
         prt_printf(out, "mode=%o", inode->bi_mode);
         prt_newline(out);


Thanks,
Youling.

