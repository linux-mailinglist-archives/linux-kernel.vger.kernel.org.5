Return-Path: <linux-kernel+bounces-95339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FAB874C72
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A61D6B22E2E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330461292EC;
	Thu,  7 Mar 2024 10:33:15 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA278562E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 10:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709807594; cv=none; b=TVNozemUtYuBlZVklZR5S8Htr7qcdyYwQWi4ybeoPJGorM8iPlOVZCrcnO0XKd83KdMzXnYedAmKhb0UA802ayhGB1OzIkiPfvCetrbxJPiFztgPXooMtNwckH3Z2NB8d9ZUSMHej+byVmVR7XYkOQ9CGiLDZ+Zcy+/pXgF54zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709807594; c=relaxed/simple;
	bh=NoH8jKuzyRK03BSBc8hA7b8UHGaVjN7/4d3TBjyC6iU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ouWIxPu2BooL9sPsa1s2yK7C56rnydP3LbyG2pKavMxRH+7ygfNdrFnPAuEXUBFUrYNq54vgd4CEj0W/IL3MV14YYQlhENOU4ou8zjDRxFFMDtGJs1v1pjHxMSlGWVcnZd3mYPm55rG/m1b9HRJTt5D9DiXCuGZNPt7LhbFkWVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33dc6df042aso170447f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 02:33:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709807591; x=1710412391;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G5SEuU829SBeN9Z+FExisYI5Ruv+jv1Pb0lU4z6MqnQ=;
        b=YZXfPHUipdFeU7y1m4HEIc7CgX5nkOLdgY2HjP9juFn+nRnlkgeemOy/0txXlOWlYq
         zZbh6PqW5oagtXd+f3PJhgjMlx6T+BFmybwRPSyMZoogPVmzxFI/PVQK9b8SVfNVq7ea
         2x99FbRBmpyAD/Jszvla92k0NeG3+uyt/rz82mkLZBQ0yVD8UeVS8gY4egFuqw+t8c3n
         Czzt3Ew4aijlmIdXET8/Qo3c9DDjx9JNjzDVtUILGWmbJBb4vyY5zzjHgLbBrPxKnhTR
         oBG6JNBAY2bA1odGFLA5YEHUKx1vPICKWnImAFtkmyVq3409mZYwqkw+e4PN17ea7EfL
         ehnQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2W0RNkNnmWoYDXrtjNrHHHAy13HBE0LLli132mXruWKAJAxcYemAAlr7SSFkJ5p5rAiCNLrhFwNSWJ/02t5oD2AVJUGj/VdsnkYLS
X-Gm-Message-State: AOJu0YwctFrJv+bD7byAoYkpjfatp0QzEabmnv6kbCkxJ4QeDWH9R7Ly
	Lp1TG1IEYv9HYmDh+j3e5seqtW0SrNgGQ/qAfNFHw8k/1s0FecDx
X-Google-Smtp-Source: AGHT+IHff/zjCAil3urGqIuISab9jNt7BVFuGYd3uE0CYWRalE1TN/cSle17tWJkT33DYNV96GXQFA==
X-Received: by 2002:a5d:5447:0:b0:33d:9ee1:48db with SMTP id w7-20020a5d5447000000b0033d9ee148dbmr992972wrv.2.1709807591497;
        Thu, 07 Mar 2024 02:33:11 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id u20-20020adfcb14000000b0033b7ce8b496sm19788995wrh.108.2024.03.07.02.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 02:33:11 -0800 (PST)
Message-ID: <6811acef-143d-4104-a814-d3cb0811192b@grimberg.me>
Date: Thu, 7 Mar 2024 12:33:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] nvme-fc: wait for initial connect attempt to
 finish
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240221132404.6311-1-dwagner@suse.de>
 <20240221132404.6311-6-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240221132404.6311-6-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/02/2024 15:24, Daniel Wagner wrote:
> The TCP and RDMA transport are doing a synchronous connects, that is the
> syscal returns with the final result. The operation either fails or
> succeeds. The FC transport offloads the connect attempt to a workqueue
> and thus it's an asynchronous operation.
>
> This async connect feature was introduced to mitigate problems with
> transient connect errors and the task to coordinate retries with
> userspace (nvme-cli).
Maybe it is a better idea to let userspace handle this? the whole async 
connect (and reconnect)
just seems it is causing more issues than solving... I may have missed 
some conversations
about this one...

