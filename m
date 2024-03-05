Return-Path: <linux-kernel+bounces-92939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F0F87285A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25CADB2B666
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B3212A147;
	Tue,  5 Mar 2024 20:11:08 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8344617BDC;
	Tue,  5 Mar 2024 20:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709669467; cv=none; b=PuUnpcoDq/CGlz7aKzYeCSec4PWyJUt7Nw3g7xTQvrgunv7TvWwltjiJeQoowhxCA5i4CVhelYum0O2TgrEnB7LV1lC9hTCiaxlFJjYZawYRw6R7cfK+Wr7SRUuCQwUSUp+B4aHXhewEgcq98AGBlaw5MV9+Dzrcg9zpNV++QCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709669467; c=relaxed/simple;
	bh=cyM8SsNOln+fPTWT/pJg4ttteo8FpdSSoEfrCVFeETA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U8bmNS5dr1sZau0v39kxkeRqHlOCsL6F+h9fQMGj270P1FR++r+66tZ4qnt5AatYJqWrgZ5RXgTiAZ0M3uCmDjXNLtbfIKfEaBoUPO8LLgIEBVDUddortu2oTSyBFVxYE4kkpWssnNUv0DNWMBNnVoEJiDAZcnuyckjY2sUeeIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6de3141f041so4183192b3a.0;
        Tue, 05 Mar 2024 12:11:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709669466; x=1710274266;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cyM8SsNOln+fPTWT/pJg4ttteo8FpdSSoEfrCVFeETA=;
        b=pvhYu5ux29EYq/llSQO5xivnqXH930YfHa8SMKJWycInUTFI6Jom3VopWa26CaUiFI
         phQQCMcF63UHCH2pzhv4i7b/8N710s+/CfwLI0BlPcMPBbcxQgwpWjZ2wI3r074h+TYA
         Xs3qxWJRwMSA6huoR3edh1FmnXriCh+kW+p/jp9kVTC6g/geK4fvUdRFSWpKKiORbewX
         XtZRwceGNXjD46Jf6dgOx+rQz+OgB+crkC3jeZCnr5zUib10EgRdHOY6vSX8yAP6CRgA
         O22YDGfMNPDTdVaz0oRCtnTp3zaKphL2TU6saOArtH0O5f0Yoz+Iwh8fsDa2Ckg1QvvJ
         bTKA==
X-Forwarded-Encrypted: i=1; AJvYcCVpvxqZqAZjaNR/PMcPbQeM94Phzv1SWhToQOuLkFOezQB756ocKkKBKsd8Lr5bcM9hwlX0eZBYREFQ4do0smliar2E12cBMozS/XGGKDeue+KzBVohaK2QkQMPpUB8M7JOGWrblhLJJg==
X-Gm-Message-State: AOJu0YwSEVeQSNQOcHgKCy12csr8aWL1VFA50uoIc/sCahS9Xdef1uiQ
	dRjPGg9cKR8Ga8mrzhOabaRiT2HBET6nSEAP0HZlMAWEvrO1D7UaaIX53kn9
X-Google-Smtp-Source: AGHT+IFNgvpXkwuhKsD33XOycGl46Qah/uZEIpMWJeUuHTWmCUX5s7Q6IQmIWQrgrZn9+XcXj1l7Uw==
X-Received: by 2002:a05:6a20:4326:b0:1a0:fc33:17a7 with SMTP id h38-20020a056a20432600b001a0fc3317a7mr3165168pzk.27.1709669465548;
        Tue, 05 Mar 2024 12:11:05 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:3e11:2c1a:c1ee:7fe1? ([2620:0:1000:8411:3e11:2c1a:c1ee:7fe1])
        by smtp.gmail.com with ESMTPSA id h11-20020a056a00230b00b006e635d89c6asm2155138pfh.147.2024.03.05.12.11.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 12:11:05 -0800 (PST)
Message-ID: <74445ebe-15b9-408a-9d5a-9d03d28d836a@acm.org>
Date: Tue, 5 Mar 2024 12:11:04 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] scsi: ufs: Re-use exec_dev_cmd
Content-Language: en-US
To: Avri Altman <Avri.Altman@wdc.com>,
 "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Bean Huo <beanhuo@micron.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240304092346.654-1-avri.altman@wdc.com>
 <20240304092346.654-3-avri.altman@wdc.com>
 <4f766df0-b1df-4e5f-8acd-31710ed4399b@acm.org>
 <DM6PR04MB65756C6716317F7E1E47FF50FC222@DM6PR04MB6575.namprd04.prod.outlook.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <DM6PR04MB65756C6716317F7E1E47FF50FC222@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/5/24 11:54, Avri Altman wrote:
> Bart Van Assche wrote:
>> Please restore the "lrbp->cmd = NULL" assignment. I don't think that it is safe to
>> remove that assignment.
 >
> This is a redundant assignment - being set to null in ufshcd_compose_dev_cmd.

Shouldn't this be mentioned in the patch description?

Thanks,

Bart.


