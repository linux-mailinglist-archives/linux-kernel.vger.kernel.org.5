Return-Path: <linux-kernel+bounces-74686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 010E185D7BA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81089282E30
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F394F605;
	Wed, 21 Feb 2024 12:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0/SbFSn"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4907E523D;
	Wed, 21 Feb 2024 12:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708517535; cv=none; b=hMsv7oe1PsOxP95m53is9YWPkVn5KHGEblyVvVJZxWGhYw+QB06iKqw/qeV1NjZ2f1TlcgO4uMY48RFSo72ZPn3QlL9Xjr7uuaId6c2yTRZ+jPTDemCeQMo7qo45kR/lZcaTLqCxirFleV/gueHNF8HVmB7DF9lQFeWOK9WX5p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708517535; c=relaxed/simple;
	bh=+N00AKpZ7J2ODw+foLQY6q9YlapQF1eaDkMorrMhEEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BT4FDcYlwq1ifhsJ88/viT2qZ2bRB8qmcHJDkCBYPPIQNxVHwKMJ/uyN+XjGObr9ZlWXxK+kpwT0hZSc2/bs/9L81UUBXThXMsdLXIr5PUO95qrDL9JguZ+h5ipt6RmtLvhTbUesHvHputQxfIpAHQEgXCK91qscjhahfeQ36JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0/SbFSn; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dc1ff3ba1aso12622645ad.3;
        Wed, 21 Feb 2024 04:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708517533; x=1709122333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H8qbWRcjaBqAixK335JcZcC9lTsg4DX0lD6Zkn6qa+g=;
        b=J0/SbFSnyf0TMrBbU9UN4dwkugqGnitxVi9oGD4vivTWUyYw5nJi1HGGYlPjgUQ7Ol
         m5WyNKY+3k/bc8k4AE3z6BvapSVtCFgy0i64YrB0Z7yfRuB6wUNT6exbegQUXEgiNzpA
         /p7DPKXswpNAEFxe2HPWA4tKacAXiQWTGFlrpN1awiSA8SBOnC78oa8tA/Wx/Y6RHvO9
         GtMitwsBky/S6loQHM2Bg1xzaW2Qufk8Z4irRrDNrcgyaZEzkndsNg6PQcyn4DD30OKT
         hEyyHfZ/3A0J7hVjgVDiVFll0814iIo9mNvKX1hCh7L3kdN4hUhYLpJ1n+gumNhA5zkS
         g6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708517533; x=1709122333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8qbWRcjaBqAixK335JcZcC9lTsg4DX0lD6Zkn6qa+g=;
        b=PtMkxg73vvBXBbiicEht9ZF7qG7FY0uHLHsF6ZWkCh6q6MeQlymcpjGXXbtru1MnZP
         rDn+CEkx05aY4r/dNpBF4EUo+xNg8TEDMabbxWzyLLfmfoAbOzIov9I9gGnzYtNCDK+p
         s5yhFL2Z4ulKTVa69xWvaCnR/lFDgtvNm7sqz3WFUXUqfVsdhM65/ymLVVb2hWYlMDvN
         ODpwnA6nemLf6N3jDyx3KimYPH9NvGEW6zD5n7b7mcWCR7QBSPgIArDj69HnTDcZX2/8
         5oGSttBdu4PVAImRdKCmIbEhatdpH2fAMPDPOtLm47m+Pza+zogEzkl8LAswcaYClaqF
         ypMg==
X-Forwarded-Encrypted: i=1; AJvYcCVP+P8YkcPkvNbsz7mcEeNEnZg3pKnw8PnZ0HV8aYPufSbVBmxu5+k4kykefq2zO0hRE6IYL6Reeyd9bHuzi4RTsYF0oNfzjqjG7UrrZ95tU19Drl4BCjcztt1q19egDVuC9dN2
X-Gm-Message-State: AOJu0Yw/PRLDxsxIFU4YMHyItJkC3Kn4ra8E+3LkxfPyht2T4wD8iELY
	94H1SWkTx7kKmp/SBA3O7ZImwSO3Po2Olfw0MqDKPbWl0Bxdjkn1
X-Google-Smtp-Source: AGHT+IHtcbcaPU1cuzHOPpHw6dBbxnjuILLkDnjB8c1TjMSfrMiGMelmDTm4Gws0oMtZ/UzhOe/WyQ==
X-Received: by 2002:a17:902:8501:b0:1dc:791:9941 with SMTP id bj1-20020a170902850100b001dc07919941mr5795930plb.65.1708517533456;
        Wed, 21 Feb 2024 04:12:13 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id kr7-20020a170903080700b001d74502d261sm7941572plb.115.2024.02.21.04.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 04:12:12 -0800 (PST)
Date: Wed, 21 Feb 2024 20:12:07 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Cc: j.vosburgh@gmail.com, andy@greyhouse.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	rajesh.sivaramasubramaniom@oracle.com, rama.nichanamatlu@oracle.com,
	manjunath.b.patil@oracle.com
Subject: Re: [PATCH net-next v6] bonding: rate-limit bonding driver inspect
 messages
Message-ID: <ZdXol6g4Jxx0VM_0@Laptop-X1>
References: <20240221082752.4660-1-praveen.kannoju@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221082752.4660-1-praveen.kannoju@oracle.com>

On Wed, Feb 21, 2024 at 01:57:52PM +0530, Praveen Kumar Kannoju wrote:
> Through the routine bond_mii_monitor(), bonding driver inspects and commits
> the slave state changes. During the times when slave state change and
> failure in aqcuiring rtnl lock happen at the same time, the routine
> bond_mii_monitor() reschedules itself to come around after 1 msec to commit
> the new state.
> 
> During this, it executes the routine bond_miimon_inspect() to re-inspect
> the state chane and prints the corresponding slave state on to the console.
> Hence we do see a message at every 1 msec till the rtnl lock is acquired
> and state chage is committed.
> 
> This patch doesn't change how bond functions. It only simply limits this
> kind of log flood.
> 
> Signed-off-by: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
> ---
> v6: 
>   - Minor space additions addressed. 
> v5: https://lore.kernel.org/all/20240221050809.4372-1-praveen.kannoju@oracle.com/
>   - Redundant indentation addressed.
> v4: https://lore.kernel.org/all/20240220050437.5623-1-praveen.kannoju@oracle.com/
>   - Rectification in the patch subject and versioning details.
> v3: https://lore.kernel.org/lkml/20240219133721.4567-1-praveen.kannoju@oracle.com/
>   - Commit message is modified to provide summary of the issue, because of
>     which rate-limiting the bonding driver messages is needed.
> v2: https://lore.kernel.org/lkml/20240215172554.4211-1-praveen.kannoju@oracle.com/
>   - Use exising net_ratelimit() instead of introducing new rate-limit
>     parameter.
> v1: https://lore.kernel.org/lkml/20240214044245.33170-1-praveen.kannoju@oracle.com/
> ---

Thanks for your patient update.

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

