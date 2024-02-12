Return-Path: <linux-kernel+bounces-62168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2546851C95
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4827228338A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664C73FB39;
	Mon, 12 Feb 2024 18:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="DcuaivSv"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8FB3AC14;
	Mon, 12 Feb 2024 18:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707762015; cv=none; b=o45UhjQF1GqpkoCCempLI84b0QB70AG70yJ9t6epM+ny/JE82mWVwwTMvSLKTO6/oF6owVEEYaqWK9AOl5FZJymBCJy4kNwdIWPaf4IAjWulMaYRFt8R/Y2Vi0msvvh4N5VecMnqJdTTZphc364zE/d8maOfPjnrUMsrEiy0nVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707762015; c=relaxed/simple;
	bh=ZCP+w/TITlYZsUPwBTl2RYdQNsKViaFu9DOVpb01ld4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOCpH7B3oeGvjKA7qR0dfbpV0MTfQ/L+X1nvyxckOejKcJmf8NeYUKTSrilMEfgKDEuuzUEfoAamSEDNVpaq99vfU2TUlkOgRIxbgim160E2dcqevi7BGpGvppaFo9LHzfStok/SOlzTE0SDn4CrMYCv5UYn4GVy6HkQYtU76Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=DcuaivSv; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d51ba18e1bso34481525ad.0;
        Mon, 12 Feb 2024 10:20:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707762013; x=1708366813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DGDodchALbPjD8ImhFj8RtfLwSSDNT1+KG3XSVPPKB0=;
        b=vUxyAgtGdXZXuQuHr6VW5JGpIy4orVIRSdDg3bzRQ6Rr0ZXiHnLZD4RZgLAfMSLvHH
         Xa8MY1+FUcL/72zWiA/bSpVhVfouiQN8OSCcNyCB72Altunt1HjFf4VuorY1WzWhf0BX
         2EBu0eBJTO4qN2G3rwDtbB/1+02drNKyzjZBjCjZHQiDUnStv/FQV3Hr8YkCbcG47OiC
         rOaWfQuIGcxC5pHS6Pr1Ib1lRTzqPGLrKNRwqacTz61YnwD+stGgpZLPGOmQATl5vG0v
         n9T6j1lehdD9kI/d6RjGA2CFCl2ZyGJdGKrcEYy+9atP2shzQk8KnwVEi4lGFKnwfTwe
         hPjw==
X-Forwarded-Encrypted: i=1; AJvYcCVRQjLnZe4D2uOmV2WNoAIQYK4bwP3eOUzl/ekHnwjWCMtqoApr1jEOFkyc1qdG9nclX9Y5cvWZDUxMuQOcAnk8q3tbQxFksfPib6IAFFza+r4lOCjD8+lwwruT+jO6VRf//5rdqtkjxw==
X-Gm-Message-State: AOJu0YzXCnMgWg9DC8LEhpptVQkWKn7eLA5rUwG23FfPnc23gRjUBCrJ
	jmQlUaYqsDFDhrC1opLUH++dd/pyQB4IgH3OONPYBmKeDg2dFAWM
X-Google-Smtp-Source: AGHT+IHYN52DdD2VqIpGmZMxcZhgZDVehkUp2p0cSRubiFOSjZa0mrvp9OCrMfalT0t7DGKG5Qsopw==
X-Received: by 2002:a17:903:25d2:b0:1d9:a50f:9419 with SMTP id jc18-20020a17090325d200b001d9a50f9419mr7837976plb.40.1707762013104;
        Mon, 12 Feb 2024 10:20:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWuH9K6UKesaBEq5fAhecLwkjwai79dwPPclSnTWn4bxr9cTjQl/0CPb8dKDFuSzaCqr73QDTf5AfpdJA6KoISslO/1LjRDbogui/yltidMZ6iJrSC11QBp9/GT/AhDiWGRMHYFzPxtM6qGDmvROu6Gz7TQWDo3wbFeT42EM+UFVXvsD2WMGjannauFE0F3QvrW+ggGdckHig==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id y18-20020a170902b49200b001db2b8b2da7sm97036plr.122.2024.02.12.10.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 10:20:12 -0800 (PST)
Date: Mon, 12 Feb 2024 15:20:47 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707762011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DGDodchALbPjD8ImhFj8RtfLwSSDNT1+KG3XSVPPKB0=;
	b=DcuaivSvY66A+jJnfMd/IQo9yo1GJrDPlYF70FJjO4nDObSIB8XSC2J5OHAmMQTiYHgsLW
	CmvHI3j+Zw0V8DmDdw0tHWtN6XXGgLJm4WFgtr75Srs6r9HmqdUNGqQlJd5nZsUD8+kAyq
	x5CKGuTrZol4WzqgVwDFhHO3R1x/VIkm05mfHJP/PpIaeAIzNRdmL7rWQKM2WQhmWnJdHJ
	Sp8dKvhEPLwnJ3OrodmkD9fD0cmsMBEh7IVxUXrfFKNUIpAzvjn+1tTOSr5ATrAuTykxkU
	KBcbpMQ6Jn19e+QAKiHa7RnRD7nB0d9jFsg4U3SJfvOROf9zsz6Kj3Ki//gGEg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: Make scsi_bus_type const
Message-ID: <kjk4kdd6tqbss2ygyrum5skmyypcom2jqm6bhqhi27zkjiktb6@ljtg3nf4nyc6>
References: <20240211-bus_cleanup-scsi2-v1-1-dd04ee82e6b0@marliere.net>
 <2024021246-canon-planner-2bf6@gregkh>
 <zcv7kteidcnqj3kpiwwmpdytuirhxbdnzri2rfmumujftthyft@xvcqzmyr2clb>
 <8d86ebfa-98bc-4752-b413-1ebb98276082@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d86ebfa-98bc-4752-b413-1ebb98276082@acm.org>

Hi Bart,

On 12 Feb 09:42, Bart Van Assche wrote:
> On 2/12/24 03:30, Ricardo B. Marliere wrote:
> >>> Remove some extraneous whitespace.
> > 
> > I saw some patches did this, thought it would ok to add.
> 
> Please don't do that. Each patch should only make a single logical change.
> Additionally, making unnecessary whitespace changes is controversial because
> it makes reviewing and backporting patches harder than necessary.

Ack. Will send a v2.

Thanks,
-	Ricardo.


> 
> Bart.

