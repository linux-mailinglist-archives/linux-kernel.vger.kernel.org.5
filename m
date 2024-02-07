Return-Path: <linux-kernel+bounces-56120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACA284C643
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DFEA1C24B92
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD08C200C1;
	Wed,  7 Feb 2024 08:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuMsredO"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814A2200BE;
	Wed,  7 Feb 2024 08:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707294453; cv=none; b=BreZUzgUygInPNRieaX3JfPPYz795dMOzpi29kKajNhCvMyjGwP9wyOx6UvJB58nUxsFutB1C4GDsRPraqOgsAUUP1jcN+nzikVryVuFGUc3PpZ9eIHIvaurSPk9CpU+fE7UlLwzg8BDJNcDXHoYvjeVHiwxTn5v8j+iDR+R7nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707294453; c=relaxed/simple;
	bh=q3wDOQ4QmJ3MQ+2IY1QMHkLo580K1oHbEpG9InAqN9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6eT0LDfKb6tt3ROfAxYuGZAJfSOiwdYAav9xhwDdV48dGoNxcjNBPN8rqARg73/tIRPDBroxbK+nsTrNAzLo1gNfKROHwJthUAl8VcA+FPOK4JNsiHyZmtFxwLEnxtE18RslHjGxSEHR/ilf591y76IY8jM+sF9AE5NkILsMao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SuMsredO; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55cca88b6a5so366842a12.1;
        Wed, 07 Feb 2024 00:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707294449; x=1707899249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SW9j0j1ERBwFUqGR0euGumuXI6Xx2VO6uxxu7v25BCU=;
        b=SuMsredOjaUGdW+Ubpsyi2F+yOeEUzVmPIXNxUeheJlcMDo9QGYWQJsQ6D5lyIyonn
         JurY6W3EPG7VlWCAwiFDOSOsNhz3B+vmRIJ2NYWoRItwpLtK5BkhUcroQP5FKIQ1imrm
         0SwAsoDRRn9qRemxOdw9pqLFqkGe36yd42OeVsDyMo84b4rH8J2ALTYittC0JU/DitzH
         GSDE+wvf3pOfOZO5HD4ViuhVJ2sK6DHV2q6E11fRWvABHqhZ60yqIjbd2ccdU8UGYQwL
         zuo0al73Jr2zNwfCrhWCdi99fLoPnwob4XmukJwxST1J4rSUPz4NxRbvaEDeRmd2ezby
         maNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707294449; x=1707899249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SW9j0j1ERBwFUqGR0euGumuXI6Xx2VO6uxxu7v25BCU=;
        b=FveDp109MF4EdROW51GLTTLqM+xBoOY3OLQ+kpksO7KobG+End2tWHYl2w78Yz3zhf
         zCgt07lXi94JDpN14FKfRkrHl8aZ3giCIG013uTyH1d80xAJY2zr25/Ib9EeIyTSVz23
         oQJ9BzL6hH55AXX4mpi/PBG0vKfqXkwTNWv/Dzwu18/tWgVhPHLoK4PxHBK9f5yDjeK4
         7wP/0PlYxUz2YVVgoy+XmV6X/pAj7suNr8Dmu2phpQfRhhnH0XEkdGWEUtbTqVMg80EK
         sHNLHHwprdDra2GKqa9JGkBCIC8vc7LWFaFCELpL0k916Z1QLHY/bw9VbArDOajGqln7
         bXjQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9z5Vg66ks+pccLMnZQehx0svdncfP9THh75+GM+iHNdyHnqoqxzBm9e7VeQvbEuD0WWXXAJoeWrzoEJdajNOh78iIDp6YHqTpIC3c1OprGHI1O6IyDevPcJB8c1tHwzWvURVSmdekuoI0CQw8BT2jCf7biXqBviXfpKfSGGuGYzHkSg==
X-Gm-Message-State: AOJu0YwOoIWj42MdG/W2/rZQceDEKmvklZ34mfHBGR8MaUdLwm2XEhBa
	/QdzaEFGVXSUbYXqzDxNpZWMJrzcp/yj+y4WUA29bJjd14mCcRvv
X-Google-Smtp-Source: AGHT+IGU7aEV1mfWep0b62bjwFwCpQqhdWfdLZWMPu14onms6VycuQTfU1qz38oQKsr65tqya+m/tQ==
X-Received: by 2002:aa7:c317:0:b0:560:c8cb:c2c8 with SMTP id l23-20020aa7c317000000b00560c8cbc2c8mr1166147edq.11.1707294448972;
        Wed, 07 Feb 2024 00:27:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVzJFpQRqUyXagh0P2eDDJCMZBGufD5AXxQNl6dvFEBKib2gluVEo8iuzqytNl2gdXrTzxGA6cdvRQDk0VQevjEjtiKt4HhRCyrXSPnSQn5GK9m0RT1zgvrKx6uLJPHTKnZi5zOsuksibr1kKDlEVPRky0xWg8QtqHRUnaAA5szpDIUHL7bh+GWyPf1YGEf4OqQmDsvVUWwbloY5G49GsPQWE/QO1EAQCt4TYn9H3ikOireYYeXmkhq1PPD4FZPR1hsCASucRQ7CE4q2RumqzI7ipOG6sg/v5Y+0V7GXko4dT7X1JlY8hvjBjywzKLjXzYw+/4mnUZrIcVvhd/azAFrFPPpN6rj
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id v30-20020a50d59e000000b005606b3d835fsm444109edi.50.2024.02.07.00.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 00:27:28 -0800 (PST)
Date: Wed, 7 Feb 2024 09:27:26 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Li peiyu <579lpy@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: humidity: hdc3020: add
 interrupt bindings in example
Message-ID: <20240207082726.GA18294@debian>
References: <20240207074758.4138724-1-dima.fedrau@gmail.com>
 <20240207074758.4138724-3-dima.fedrau@gmail.com>
 <626fe429-98b3-4319-b104-ef66e4b7afdd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <626fe429-98b3-4319-b104-ef66e4b7afdd@gmail.com>

Am Wed, Feb 07, 2024 at 08:54:57AM +0100 schrieb Javier Carrasco:
> Hi Dimitri,
> 
> On 07.02.24 08:47, Dimitri Fedrau wrote:
> > Add interrupt bindings in example.
> > 
> > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml b/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml
> > index 7f6d0f9edc75..5b3f9670fa52 100644
> > --- a/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml
> > +++ b/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml
> > @@ -51,5 +51,7 @@ examples:
> >              compatible = "ti,hdc3021", "ti,hdc3020";
> >              reg = <0x47>;
> >              vdd-supply = <&vcc_3v3>;
> > +            interrupt-parent = <&gpio3>;
> > +            interrupts = <23 IRQ_TYPE_EDGE_RISING>;
> >          };
> >      };
> 
> Did you compile the example? I think this will fail because you don't
> have the include for IRQ_TYPE_EDGE_RISING.
>
Missed that one, thanks. No didn't build the documentation yet. Will do
that.

Best regards,
Dimitri Fedrau

