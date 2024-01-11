Return-Path: <linux-kernel+bounces-23695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA4A82B024
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 808751C23C7A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001F53B193;
	Thu, 11 Jan 2024 14:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ImuNqmsu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20FA364A9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 14:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704981768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w2oiHnQxHwv2fW/BCjTbKgiDncxKv4ZkLpJzyQn0qCM=;
	b=ImuNqmsutg4HH0p0xt4pERAono3Djfu0ugRIrFOEyAoZ7RY1AYoj1bGRmD5b5xR3xlgUqO
	xmU1J7D8uJg5xWE0NOFPyJZqNlgRKyOZQ/VE89RFcXLFtBlgw7VWR5pweVFn8XUoFoSyv7
	1NgqkjfrZ3HgNZNnknGG6QRgOTOSBF0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-myWOWmRJMFCjHyLyB1xOUg-1; Thu, 11 Jan 2024 09:02:45 -0500
X-MC-Unique: myWOWmRJMFCjHyLyB1xOUg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-67f943c0e6bso88147246d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 06:02:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704981764; x=1705586564;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2oiHnQxHwv2fW/BCjTbKgiDncxKv4ZkLpJzyQn0qCM=;
        b=wDm0OQd9+a6qlE2z1SEAnWDzH5h0sWHu+M1NmRAxO5IZEsIPvtlHF5MTPB8Sc1mEfW
         VzDmZgHMBAA1AC07nUsvq18VPfVj+2r7BZvbiEw3to30OALGcrqVH0MsKV6MKe+0hQgf
         nZhQkru2kuMhQsg5LlPhru9kRDw3sxF9aYl96isCLqWBIajeHHR3XWC3ypo7Gu0VpUAM
         cC2BNlKd42mQ+sSBdYcpChY2QaTWEAjKsilYO37N3PXhhhyt5RrNbjlufntCRg4ZbONO
         /r8hWG31W3NJvdWM9bFehRplkFLSqTlOzVRRBQw0c/H+kCYjem2sk0rzq2IfkgMNhq+1
         n86Q==
X-Gm-Message-State: AOJu0YyIuHJwPHI1m5YwyoVM7qcTFaldqIpV2HqAN0Zyi41ZLV9chDEd
	wD7ORUwAHhFxnLZCFfxTISjFIYktsgGzwjIKezD/J29Sec/dt+cuS70Acjt/VyAFlXYE9wet6+0
	AWzpmYsz4Q1unfC7G2Bb0nK1qSAaFP+On
X-Received: by 2002:ac8:5841:0:b0:428:318f:e484 with SMTP id h1-20020ac85841000000b00428318fe484mr719670qth.108.1704981764089;
        Thu, 11 Jan 2024 06:02:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtflAELoemq0nV2Xk8B+wSndOSPvHCcElj4MrMOV9ESDLlKwYt2d36MOLJ5nZhJxTYASh33A==
X-Received: by 2002:ac8:5841:0:b0:428:318f:e484 with SMTP id h1-20020ac85841000000b00428318fe484mr719653qth.108.1704981763747;
        Thu, 11 Jan 2024 06:02:43 -0800 (PST)
Received: from x1 (c-24-2-114-156.hsd1.pa.comcast.net. [24.2.114.156])
        by smtp.gmail.com with ESMTPSA id cg5-20020a05622a408500b00429ab4df47csm451462qtb.17.2024.01.11.06.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 06:02:42 -0800 (PST)
Date: Thu, 11 Jan 2024 09:02:41 -0500
From: Brian Masney <bmasney@redhat.com>
To: Lucas Karpinski <lkarpins@redhat.com>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sa8540p-ride: disable pcie2a node
Message-ID: <ZZ_1ARhDxYNk7Gt2@x1>
References: <qcoqksikfvdqxk6stezbzc7l2br37ccgqswztzqejmhrkhbrwt@ta4npsm35mqk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qcoqksikfvdqxk6stezbzc7l2br37ccgqswztzqejmhrkhbrwt@ta4npsm35mqk>
User-Agent: Mutt/2.2.10 (2023-03-25)

On Tue, Jan 09, 2024 at 10:20:50AM -0500, Lucas Karpinski wrote:
> pcie2a and pcie3a both cause interrupt storms to occur. However, when
> both are enabled simultaneously, the two combined interrupt storms will
> lead to rcu stalls. Red Hat is the only company still using this board
> and since we still need pcie3a, just disable pcie2a.
> 
> Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>

To elaborate further: Leaving both pcie2a and pcie3a enabled will lead
to rcu stalls and the board fails to boot when both are enabled. We
have the latest firmware that we've been able to get from QC.
Disabling one of the pcie nodes works around the boot issue. There's
nothing interesting on pcie2a on the development board, and pcie3a is
enabled because it has 10GB ethernet that works upstream.

The interrupt storm on pcie3a can still occur on this platform, however
that's a separate issue.

Brian


