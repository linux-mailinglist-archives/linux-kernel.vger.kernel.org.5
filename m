Return-Path: <linux-kernel+bounces-86478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CD986C60A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9239C28181D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A3D62804;
	Thu, 29 Feb 2024 09:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="PzP1LUgl"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1A762158
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709200265; cv=none; b=ezeMBxgzQiPwiRSgKW0dRyhDzptyXEH1/xSyv3I8FbqlCIZHel7KZwmxo0xZC6w/5ihnsE7Fx91Ji74AsCp2vS9Mf2FthenfxYERabl+V2jhiXV90AWXcXOzxoTB4SLBkmCELHvg5f42w9bjX8pk3rpdzYSLN+ZAKeqwgIOKDUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709200265; c=relaxed/simple;
	bh=cRX3Bvrv5VMJbH486cxwzo3aXNisJ3IEqyG5/qP66So=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ATxcCe4GrZi8rvzppfoVuHNDO6IsEjufSxBJrm5OAkq2jiGYFDv8SflhguUHTIdZUvI3mXtaY+NYW5FyzLcPb5XVTHAZOwtr4bsE3Z3UnYWLmkC2W5+q0JiGA2t9tjCojzgoE3AXEom0OkZlJhEjc5FSda0fqdYKd2JJ0RDDJzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=PzP1LUgl; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lIkWhOu34ME75LlWJhBuvExpb0Fbqyl+X83cYuKX2ko=; b=PzP1LUglhe5oEaqpwHf3bPjNQn
	5Gh4draNN6279gQpWjZ6576ByzWRxSddwOuYclWHSUNhQ9BXXoqcRjf4/cj11WXQYgBxHjpSvQjHQ
	JKCOAN7MJ59/GLkiLhWUzJmAHH7cfhv6X2xiGcGImF5OWmGm1f5E8nWCxe8xhktW7yI9AKu0J/vBt
	M/EM+4Bl/aOqC62xXMQ1/zJ+kifoQCto7fsJCsaq7OLLq3AnTcRwqVuclKGKxg8o+DTUjG8BTKeGB
	aDE1m2WsTO+xOblBUdRMBu5OGmhDoTSy9ZnDJS63RuFliBeB32Fufartr9HGxfnaB20a61wrbzpUn
	Zh8VZe2A==;
Received: from [2a02:fe1:7001:f100:f480:6534:4fd2:d218] (port=55234)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1rfd46-0075IY-Ge
	for linux-kernel@vger.kernel.org;
	Thu, 29 Feb 2024 10:50:58 +0100
Message-ID: <2475a88c-811b-4130-ac9b-36650db8565a@cu-phil.org>
Date: Thu, 29 Feb 2024 10:50:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
Subject: San OS, a fork of CBL-Mariner?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

San OS might be suitable as a fork of CBL-Mariner, by the well 
established Microsoft.

On my suggested To-Do list.


