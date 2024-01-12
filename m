Return-Path: <linux-kernel+bounces-24316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1618382BAEA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 06:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2DD51C22BCB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 05:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41C25B5D4;
	Fri, 12 Jan 2024 05:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UNa32RHA"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CD05B5C7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 05:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3368ae75082so3924381f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 21:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705037743; x=1705642543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DtbPaRfGYk6X4oYg+Ug2sqRz11ucIJoMhFdYmm6VMaY=;
        b=UNa32RHAf0Z3GDs7ki9XkLfip/YAclw52d8jKJQPdG/1Yg+tJ3edKzc1Y3ED724Y8R
         Qc4LWXWjC35U30Yf2kH6X7jiwwsegYJb9MIocjhJtZx7bwyLbGOLMeGOQBh+0E32YPzF
         lFUvNAE3SZhLgRJFK+l1TRzJrnUXgQ0YlhTjFciwclLrgDx0Xn9bPWhg18fO4+UsHXUC
         0YhVcPR552oaraK4hMeUWE1ravK7H9N+Laio6SzXPl+eNTK5IBUUCP8AkiFg0gh/AeJ6
         1KvsBVeo9n4Yk9a7idRZ3XL9ckGbk/ShDJ2N/49QQb+wj86ZRu3dSt/QSkZRNXv4Rbwt
         AZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705037743; x=1705642543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtbPaRfGYk6X4oYg+Ug2sqRz11ucIJoMhFdYmm6VMaY=;
        b=jscoTUdeJO7Qpzahi+bzdVURxeCF0eK7SUkTIT9JjncTeU8OtzLrr34HOibNq87UQf
         Up7sPKf7Frl2J7JJV0/qJbJBZ68dFX/D+EQ2bqEJ7cMQ69hkPWOqZvWZI+Y/0P/k/3Dx
         iEEOksXsXGNtmPQGTpLlgetgO2YGSIYAIDVL7zFtGDW5P/Wxbv8MkfOjacSEvqSVPbli
         GmN4sjf1WGa3O0bX+k3H/rfDfCVmnm82YHYmOfbeG12tuQzfbxyNGk3dknityq7xhJXJ
         wkmRuovXWU18c/xL3370buWOyjrpWXlq8H0SLPJf2tLXSm0vsoIhLqXZwZRvDmsyNhWA
         M+og==
X-Gm-Message-State: AOJu0Yw0K0DLUcefYlPtyaIwPw8d5qQPwhJitwTKP0I1km/cc++QHonq
	q7K7nXv0hrhRlVqOqFVADDXzsh6KdsI12A==
X-Google-Smtp-Source: AGHT+IF+AQMibTPN+FkGMXfLHyLlseLg2kIxt9SzFTA60TeYtYLwVHgAErwxfqX50O/bTggq3yItHA==
X-Received: by 2002:a05:600c:3286:b0:40e:4998:fe4e with SMTP id t6-20020a05600c328600b0040e4998fe4emr401299wmp.145.1705037742991;
        Thu, 11 Jan 2024 21:35:42 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id t18-20020a05600c199200b0040e5951f199sm4244432wmq.34.2024.01.11.21.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 21:35:42 -0800 (PST)
Date: Fri, 12 Jan 2024 08:35:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kees Cook <keescook@chromium.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	linux-hardening@vger.kernel.org, error27@gmail.com,
	gustavoars@kernel.org, Bryan Tan <bryantan@vmware.com>,
	Vishnu Dasa <vdasa@vmware.com>,
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, vegard.nossum@oracle.com,
	darren.kenny@oracle.com, syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH v2 2/2] VMCI: Fix memcpy() run-time warning in
 dg_dispatch_as_host()
Message-ID: <9d71d005-0007-4983-b5dc-251bb4bc17bd@moroto.mountain>
References: <20240105164001.2129796-1-harshit.m.mogalapalli@oracle.com>
 <20240105164001.2129796-2-harshit.m.mogalapalli@oracle.com>
 <202401081430.9DAB37B46@keescook>
 <9c742547-0021-464b-b7a8-7af46b0a4afa@embeddedor.com>
 <202401101601.30ED61A1A3@keescook>
 <8e527ade-fe49-4697-8e36-589775c63354@moroto.mountain>
 <202401111001.78284D8F@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202401111001.78284D8F@keescook>

On Thu, Jan 11, 2024 at 10:13:44AM -0800, Kees Cook wrote:
> On Thu, Jan 11, 2024 at 10:15:40AM +0300, Dan Carpenter wrote:
> > On Wed, Jan 10, 2024 at 04:03:28PM -0800, Kees Cook wrote:
> > (I wrote a patch for this a few months back but didn't send it because
> > of the merge window.  I forgot about it until now that we're in a merge
> > window again...  :P)
> 
> 			memcpy(&ivi->vlan, &bulletin->vlan, VLAN_HLEN);
> 
> #define VLAN_HLEN 4
> ivi->vlan is u32
> bulletin has:
> 	u16 vlan;
> 	u8 vlan_padding[6];
> 
> yeah, ew. Should it even be reading padding? i.e. should this be:
> 
> 		ivi->vlan = bulletin->vlan << 16;
> 

That seems reasonable.  We don't care about endianness?

> ?
> 
> Or should bulletin be:
> 
> 	union {
> 		struct {
> 			u16 vlan;
> 			u8 vlan_padding[6];
> 		};
> 		struct {
> 			u32 vlan_header;
> 			u8 vlan_header_padding[4];
> 		};
> 	};
> 
> with:
> 
> 		ivi->vlan = bulletin->vlan_header;
> 
> ?

My patch used a struct group.

	struct_group(vlan_header,
		u16 vlan;
		u16 vlan_padding;
	);

We don't need 6 bytes of padding, only 2.  Using a shift seems like
possibly a better approach.  Have to think about that.


> 
> I've been finding that almost all memcpy()s and memset()s into non-array
> types are better just rewritten as a direct assignment. :P

That seems like a good rule of thumb, thanks.

regards,
dan carpenter


