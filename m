Return-Path: <linux-kernel+bounces-62082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EABC851B21
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0909228B26D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6108C3D57A;
	Mon, 12 Feb 2024 17:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXidrwGw"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296223CF4C
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 17:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707758298; cv=none; b=nImI4Lpo4WUf8QL/4pVcy2it3sYNt7izKKJzDY40lExDPnZaR/WGr/jm12RPZTyuCSxZsyHr8+j0QHyrKqn5QR4UpIqp63XaxTYEUJl56eFkYkUWc6XtDjWejJS4IxBVXdLBeJ2Y3jkIDPPBgapM5cp3kNi0quLS6k4E85XYkzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707758298; c=relaxed/simple;
	bh=aJLhxZw/6VLXC4cw+RKcpvlB3LpEG0ldQx2kfyU4uVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpnqzW9ILIc32RTlK2Lul6LyyjiBwWUKiGerrNs+0JamfE3ct7MBp8lowXUn6F7Em/5/dBUGTqv3ZvpEQbkNvqkZw9kO4GoWUiGoLbT6yROeKgLS0lmM6Qg9M1YiqLfYnyOLc6g5jl/IGb/knuS/M8fFT+Xc6w6yQdVf3XSk/9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXidrwGw; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d93edfa76dso27515995ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 09:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707758296; x=1708363096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xCIep0DRPStcfl/IGRa0Zu4ofjT1z5YXLFif2WK89OI=;
        b=cXidrwGwFjdju3h97LeTE3ie9TrlpyMKa3PS8dtfvkCiphrlQz2wa/mABuH51V2bMT
         m8FwYzYJeXcWpEK3awFA0OjtJRWDGQ+m1L6VRYMFs3HJB4yiWfMqzmA8mCVFyd2NCfN1
         /zGSN9Jgt07lrokyMg6PswMbGnVHae6vLHpzzn7lEqH3eOJW3ltoHcmB2d6AYj7vjr98
         OERnnYp79WKwiEPpVMdm6zJR8petlJyUHIOL4xUTDGX365kjhyBlFKTZoiKBYRrkrhTr
         Hqj2ww2kUOuLkz7J4yw8d/dZUujSvQqfC2vKq+V/2EBSpUsuWv9WFOlWRlz4ET1VOyOm
         8EXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707758296; x=1708363096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCIep0DRPStcfl/IGRa0Zu4ofjT1z5YXLFif2WK89OI=;
        b=Tda5RIEffsHnDM4yl59If9B6eoaucEy7+L+XelLjCEBFNNlUmhSddgieBTLv5dddyw
         Ujf876W9Gt460Rm5gCRPTXg+V1Po5AhZ4xa4RNHn/B75rXbE5WN/z9YfyDHX81mYoaEx
         CK3WbXZ7aluXDX/2NOwxAybjfzR+hbVECfQjdeKIAdUgNOr7a6fkL6p6iwOXRrrjWtqc
         A17XhgNM2sOKlw4EUrCqVwCuWN1FHUrNytwFjvQr/+CiRAl5iPw5bswCD/fPIdEX/rgN
         Eo56LXRPWpSG3BsnVofzdXJeZfHPg6G1J85tmbCx5xBVAxRvcXpVjO2JYK8QQFCJNf7+
         5LoQ==
X-Gm-Message-State: AOJu0YxPJQ+uitogvXBXZ9rkHm8gfeAIDz/jAUD+CmiZti6Uq21O1Qij
	ePm5Dod8Ww4HKTccHj0oMCdtTGqFb+OaB/kGznpOdgzqylck4AxBqmg9wclf
X-Google-Smtp-Source: AGHT+IFoWURwgwgvKRH0QVWKaGGiNOmEse8OuCzXBqnCibQ8yGzeHDffuGcTSVv1yNbB/L1doUI7nQ==
X-Received: by 2002:a17:903:1211:b0:1d9:aa5d:a50 with SMTP id l17-20020a170903121100b001d9aa5d0a50mr10732122plh.25.1707758296397;
        Mon, 12 Feb 2024 09:18:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWYLUsksLO6TZWxtIYFLJu3MNl032gEQvyUaZQadn50tG/dI7NvMX3T6pflSFtNX3TJYJ8y33Yvt9Xy6ccgwvgmnVb68Oaev/7ILkRjoVE39OW7d/w1mRY/kqXf8FZiDa+b7WkdAkTf3C6VDsuD035rt1Khwsdc95bYUBtxn2SZHv2GcUPBw9OJKjJzluEWXKKijrLQ
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u11-20020a170903308b00b001d6f091ca04sm603980plc.13.2024.02.12.09.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 09:18:15 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 12 Feb 2024 09:18:14 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Charlie Jenkins <charlie@rivosinc.com>,
	David Laight <David.Laight@aculab.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Message-ID: <52393411-8313-4e94-9618-916b57f7d52e@roeck-us.net>
References: <20240207-fix_sparse_errors_checksum_tests-v6-0-4caa9629705b@rivosinc.com>
 <20240207-fix_sparse_errors_checksum_tests-v6-2-4caa9629705b@rivosinc.com>
 <20240212062614.GI608142@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212062614.GI608142@ZenIV>

On Mon, Feb 12, 2024 at 06:26:14AM +0000, Al Viro wrote:
> On Wed, Feb 07, 2024 at 04:22:51PM -0800, Charlie Jenkins wrote:
> > +	struct csum_ipv6_magic_data {
> > +		const struct in6_addr saddr;
> > +		const struct in6_addr daddr;
> > +		unsigned int len;
> > +		__wsum csum;
> > +		unsigned char proto;
> > +	} data, *data_ptr;
> 
> Huh?
> 
> > +	int num_tests = MAX_LEN / WORD_ALIGNMENT - sizeof(struct csum_ipv6_magic_data);
> > +
> > +	for (int i = 0; i < num_tests; i++) {
> > +		data_ptr = (struct csum_ipv6_magic_data *)(random_buf + (i * WORD_ALIGNMENT));
> > +
> > +		cpu_to_be32_array((__be32 *)&data.saddr, (const u32 *)&data_ptr->saddr,
> > +				  sizeof_field(struct csum_ipv6_magic_data, saddr) / 4);
> > +		cpu_to_be32_array((__be32 *)&data.daddr, (const u32 *)&data_ptr->daddr,
> > +				  sizeof_field(struct csum_ipv6_magic_data, daddr) / 4);
> > +		data.len = data_ptr->len;
> > +		data.csum = (__force __wsum)htonl((__force u32)data_ptr->csum);
> 
> What are those cpu_to_be32() about?  Checksum calculations *DO* *NOT* involve
> any endianness conversions.  At any point.
> 
> Replace those assignments with memcpy() and be done with that - that will take
> care of unaligned accesses.
> 
> Result will have host-independent memory representation.  The only place where you
> might want to play with byteswaps (only 16-bit ones) is if you initialized the
> array of expected results with u16 constants.  That will have opposite memory
> representations on l-e and b-e, so you'll need to byteswap to compare with
> what you get from function.  Alternatively, make it an array of bytes and
> do
> 	sum16 = csum_ipv6_magic(saddr, daddr, len, proto, csum);
> 	if (memcmp(sum16, expected_csum_ipv6_magic + i * 2, 2))
> 		complain
> 
> That's it.

Almost. Turns out the csum parameter of csum_ipv6_magic() needs to be in
network byte order, and the length parameter needs to be in host byte order.
So instead of
	data.len = data_ptr->len;
	data.csum = (__force __wsum)htonl((__force u32)data_ptr->csum);
it needs to be something like
	data.len = ntohl(data_ptr->len);
	data.csum = data_ptr->csum;

Also, as you mentioned, either the returned checksum or the expected
checksum needs to be converted for the comparison because one is in
network byte order and the other in host byte order.

Address conversions are indeed not needed.

Thanks,
Guenter

