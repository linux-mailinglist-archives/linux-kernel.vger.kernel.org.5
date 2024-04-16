Return-Path: <linux-kernel+bounces-147232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE7C8A7153
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 234AC28522D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7180D1327EB;
	Tue, 16 Apr 2024 16:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYSD1YLK"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246B6131750;
	Tue, 16 Apr 2024 16:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713284837; cv=none; b=B6I5yyA8FP7Phn7iEqxKRAWNT4tZnrQnS9t510A2JHlX482apKWzOqcrWDAK6XHj/r68irN864hZW64FH47ofcoXFLtU3aFhij5vIvY3prAZxL5pGAGYUSPHS0BdkW/a3AUntawGgjFcdG7OkpH7pEkDpJpMNfg+wAueixxc+mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713284837; c=relaxed/simple;
	bh=o94KrG4AORRcrfP2FGeeFqmjm+QABI/sj5NRotshdkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9Ozrbg6gF27IFtzts8TT+2dATI9vdzfHTarb0FqEjscTo4XH5Oraxac49XnFb+5PZpvS4BFEjgtwU6L5yzXoD4mrYG9lAdG0elbk457GmPBoQsLgl5rpZwpFiJySE9qNeCNCinzSvm+IPmBNWNrtKnL2a2lGqmYLhgWusUf7Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYSD1YLK; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6184acc1ef3so47363837b3.0;
        Tue, 16 Apr 2024 09:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713284835; x=1713889635; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VrcycaBRsHafe2yoJ2SKOElRVYaaX9jjI4hQ/cPVIno=;
        b=eYSD1YLK5DmTdpRKqMFG1QP1EoyTD8M1p23b6L4vn1ebAHb+d98jSYbYJ1XCmPj7/4
         DeIrgOqp0d8gZVSF606Knz+gsBDS+vRe46pACxG1O1SL0WlIvBWdGtPTF2qmciR1JE1E
         nGN9aZ6EfBK2ghI4lmJK2s2ScuCO7lIhRffteYJmgosBEISPXuGH7WZ3I/L0Z3+Jb+0V
         WFTNIy2IHF/vq1D6fGVYKfDUOQ3i/my9M2r9U6TFRU+peUKqurIS9KrCeRJzUQU3BGHu
         AAphFU8drCt3myiil4Fd5h1lLPoMjzGyayRspfRORx1VkFqNk69+9/rmagXxh/aucD2z
         lzjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713284835; x=1713889635;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VrcycaBRsHafe2yoJ2SKOElRVYaaX9jjI4hQ/cPVIno=;
        b=Kfu+4IcH45FWBfZuwBH4CFoHhdOv8sMCyA4wfoLGo+QSikfo9NW59Dy4J/LSHgmwWs
         j25YF0NV0pLh5ht/TavVZUWE0hqlkI3D48NQNdOPUqyrBaMrEorAVogdVlm85hN2V0I1
         3F4HPqu8kzlGuvnf77Z2C7MowRUemicoxk4HIXYfjlCAketkKUtEMPgzeCMmbYpcxHdT
         4DAik5lG29ds1S8W9DkPaqmY6RZW+QXMnP8ty6VIpQy+f8EEr4Nm36hOd57V5qS+sV4u
         Yg8RcdbnchEiSpFFPAL1TWsBzaqwi3M8flj/eVp8dp0kzNHw0TrwAXg0ykotzIftLnKZ
         aFLA==
X-Forwarded-Encrypted: i=1; AJvYcCVdG6ZS0PwwA6Ppl3mDH3xPy0hbJKNf043du1PcXRJQqgF/tk56p+m/1ubj7XjhRLPG72hc0hQ9zXs7LGdU0I157jLZf+VsXTLtRuU3Z8FbMM/FOSXeYF5VkycBbXj5iUxW76q4TLJX9Yi5vWxrMHu4jVuniPYb6xOqz3J9IfZ3
X-Gm-Message-State: AOJu0Yw5VAYJ2HHe7bP8Bs8Ct1za/y7xiIgagKgOfiMSATPrSMVPJh5g
	fNfg9/X+6/QaAMVpuFn4XgwbfIQ/22SRFDg9y//7NA4ybQqcRKiFVw0rOUp9
X-Google-Smtp-Source: AGHT+IEXsgvDfIFHbYoVQMrhr4GdjMrezfHdibLezRFh7yWqGPBE3jOHUOBRz/kf7LtpfJk57dd2MQ==
X-Received: by 2002:a81:9f03:0:b0:615:800d:67b2 with SMTP id s3-20020a819f03000000b00615800d67b2mr12111673ywn.29.1713284834953;
        Tue, 16 Apr 2024 09:27:14 -0700 (PDT)
Received: from fedora (host-79-27-41-113.retail.telecomitalia.it. [79.27.41.113])
        by smtp.gmail.com with ESMTPSA id b8-20020a81bd08000000b0061aea696527sm455640ywi.96.2024.04.16.09.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 09:27:14 -0700 (PDT)
Date: Tue, 16 Apr 2024 18:27:10 +0200
From: Francesco Valla <valla.francesco@gmail.com>
To: Vincent Mailhol <vincent.mailhol@gmail.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>, fabio@redaril.me
Subject: Re: [PATCH v2 1/1] Documentation: networking: document ISO
 15765-2:2016
Message-ID: <Zh6m3jkRovDutKnZ@fedora>
References: <20240329133458.323041-2-valla.francesco@gmail.com>
 <20240329133458.323041-3-valla.francesco@gmail.com>
 <CAMZ6RqKLaYb+8EaeoFMHofcaBT5G2-qdqSb4do73xrgMvWMZaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMZ6RqKLaYb+8EaeoFMHofcaBT5G2-qdqSb4do73xrgMvWMZaA@mail.gmail.com>

Hi Vincent,

thank you for the review!

I'll omit from this reply the issue about the standard to be referenced
and the CAN-CC naming (discussed in another thread also with Oliver).

About the typos and formatting observations: rst is not my native
language (I'm more on the Markdown side), I'll apply all the corrections
you suggested. Thank you.

Some other considerations follow.

On Sat, Apr 13, 2024 at 10:11:55PM +0900, Vincent Mailhol wrote:
> Hi Francesco,
> 
> Thank you for the ISO-TP documentation.
> 
> I left a few comments, but overall, good work. Also, I did not double
> check each individual option one by one.

(...)

> > +
> > +- physical addressing is implemented by two node-specific addresses (CAN
> > +  identifiers) and is used in 1-to-1 communication
> > +- functional addressing is implemented by one node-specific address (CAN
> > +  identifier) and is used in 1-to-N communication
> > +
> > +In a so-called "normal" addressing scenario, both these addresses are
> > +represented by a 29-bit CAN ID. However, in order to support larger networks,
> > +an "extended" addressing scheme can be adopted: in this case, the first byte of
> > +the data payload is used as an additional component of the address (both for
> > +the physical and functional cases); two different CAN IDs are still required.
> 
> There is more than that.
> 
>   - The normal addressing can also use the non-extended 11 bits CAN ID.
>   - In addition to the normal and extended addressing mode, there
>     is a third mode: the mixed addressing.
> 
> Ref:
> 
>   - ISO 15765:2024 §10.3.1 "Addressing formats"
>   - https://www.embedded-communication.com/en/misc/iso-tp-addressing/
> 

You are right. I'll drop the reference to "29-bit" and add the mixed
addressing (I did not know it, I'll have to investigate a bit - I
personally always used the normal one).

(...)

> 
> > +Unlike the CAN_RAW socket API, only the data payload shall be specified in all
> > +these calls, as the CAN header is automatically filled by the ISO-TP stack
> > +using information supplied during socket creation. In the same way, the stack
> 
> This is making a shortcut. There are the raw CAN payload and the
> ISO-TP payload. In this paragraph it is not clear that "data payload"
> is referring to the ISO-TP payload.
> 
> Also, what is the meaning of "the CAN header". Here, I think you mean
> CAN ID plus some of the few first byte of the CAN payload.
> 
> I suggest that you use more precise vocabulary from the standard:
> 
>   - Address information
>   - Protocol Information
>   - Data field
> 
> Something like:
> 
>   only the ISO-TP data field (the actual payload) is sent. The
>   address information and the protocol information is
>   automatically filled by the ISO-TP stack...
>

Indeed it is a shortcut. Your suggestion to adhere more to the standard
is welcome, I'd rephrase as:

  Unlike the CAN_RAW socket API, only the ISO-TP data field (the actual payload)
  is sent and received by the userspace application using these calls. The address
  information and the protocol information are automatically filled by the ISO-TP
  stack using the configuration supplied during socket creation. In the same way,
  the stack will use the transport mechanism when required (i.e., when the size
  of the data payload exceeds the MTU of the underlying CAN bus).


(...)

> > +Examples
> > +========
> > +
> > +Basic node example
> > +------------------
> > +
> > +Following example implements a node using "normal" physical addressing, with
> > +RX ID equal to 0x18DAF142 and a TX ID equal to 0x18DA42F1. All options are left
> > +to their default.
> > +
> > +.. code-block:: C
> > +
> > +  int s;
> > +  struct sockaddr_can addr;
> 
> Here, I would suggest the C99 designated field initialization:
> 
>   struct sockaddr_can addr = {
>           .can_family = AF_CAN;
>           .can_ifindex = if_nametoindex("can0");
>           .tp.tx_id = 0x18DA42F1 | CAN_EFF_FLAG;
>           .tp.rx_id = 0x18DAF142 | CAN_EFF_FLAG;
>   };
> 
> Well, this is just a suggestion, feel free to reject it if you do not like it.
> 

Not a fan of C99 designated field initialization inside functions, TBH.
Moreover, these parameters are typically specified through either the
command line or some configuration file. I'll keep my version.

> > +  int ret;
> > +
> > +  s = socket(PF_CAN, SOCK_DGRAM, CAN_ISOTP);
> > +  if (s < 0)
> > +      exit(1);
> > +
> > +  addr.can_family = AF_CAN;
> > +  addr.can_ifindex = if_nametoindex("can0");
> 
> if_nametoindex() may fail. Because you are doing error handling in
> this example, do it also here:
> 
>   if (!addr.can_ifindex)
>           err("if_nametoindex()");
> 
> > +  addr.tp.tx_id = (0x18DA42F1 | CAN_EFF_FLAG);
> > +  addr.tp.rx_id = (0x18DAF142 | CAN_EFF_FLAG);
> 
> Nitpick: the bracket are not needed here:
> 
>   addr.tp.tx_id = 0x18DA42F1 | CAN_EFF_FLAG;
>   addr.tp.rx_id = 0x18DAF142 | CAN_EFF_FLAG;
>

Ack.

> > +
> > +  ret = bind(s, (struct sockaddr *)&addr, sizeof(addr));
> > +  if (ret < 0)
> > +      exit(1);
> > +
> > +  // Data can now be received using read(s, ...) and sent using write(s, ...)
> 
> Kernel style prefers C style comments over C++. I think that should
> also apply to the documentation:
> 
>   /* Data can now be received using read(s, ...) and sent using write(s, ...) */
> 

Ack.


Again, thank you for the review.

Regards,
Francesco


