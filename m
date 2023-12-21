Return-Path: <linux-kernel+bounces-8020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B365881B0B6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693C91F23BDE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE27200BD;
	Thu, 21 Dec 2023 08:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O9ZCSyie"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FF51A71D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 08:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703148743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7X7gmc4/l29hpAVyJ8b4AW2EtmNt/iVyKE8KES1vr/o=;
	b=O9ZCSyieLXNjHxbkdraEi7qS1T0Jf2lXs18kOvdZOLpVfBbl6GxtJBjPRKOb+bOqb2iUSw
	vIE1rGAsPN6zPlg9EWjIGisJdCezz0NiOT7of+ICm/MkuZFnpujk1oiFfGIVC2toZ07zXk
	5eZWh4DI92oR98SrBTFVaf9KWRjxQGU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-RdMppAjmMY-iFYyHcrOF8Q-1; Thu, 21 Dec 2023 03:52:21 -0500
X-MC-Unique: RdMppAjmMY-iFYyHcrOF8Q-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a232f069e60so5841466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 00:52:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703148740; x=1703753540;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7X7gmc4/l29hpAVyJ8b4AW2EtmNt/iVyKE8KES1vr/o=;
        b=ALV/+wcYei9Ymp8XHrweStfG0iUOhULl/Gky5mtJfHuq6CQZdJtccaMYC/NXU9k/Ic
         CqzU0Bd2/S6rp6LVKHljoe4woCRGEIUMeD1VZaUNSRvOnUa3/zEfcWuLkxcv4yNrxr7K
         RXRAI2j6EEdYU64EpZ/cZqCFS0iRNtiKUsHsTTRe5xR6JSHWwtbuPff2J0xa31QkiKIu
         eZpgdmFRtOJvBLRa7aqEB/w/F2Rxy2fNkhd0ntUaGSFpYX35jSxoQlN6BUxvtFm/iYRg
         wSOD/E3lTBL9Oem+ABsFd2/7/pXbLty3jg1k1cjfWFyumJ9PD79GqG97ZpuB8oDfx0ZO
         8PPw==
X-Gm-Message-State: AOJu0Ywayz0kJzc6HpsKy6bSCp8bgiNU2r2skuQJ/TYck1gtIFH8cOsI
	uP0kbCvfw83UEh7pmYzMVssQanqSoAWgDxqo39/0aa1wtJlpBcB7wjwsaqfwauAxWyzLWO5Rbot
	LmRISkYrf3euP1YM9BxOE61QN
X-Received: by 2002:a17:906:f586:b0:a24:71aa:5d9a with SMTP id cm6-20020a170906f58600b00a2471aa5d9amr5989561ejd.4.1703148740463;
        Thu, 21 Dec 2023 00:52:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkWOmvfm5Uc4lvCyixclsvCOA+olyWgz5y1O8rGNnBK5PHkuVgH/Hw/d0KoPDQe95elbqLbQ==
X-Received: by 2002:a17:906:f586:b0:a24:71aa:5d9a with SMTP id cm6-20020a170906f58600b00a2471aa5d9amr5989546ejd.4.1703148740174;
        Thu, 21 Dec 2023 00:52:20 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-246-124.dyn.eolo.it. [146.241.246.124])
        by smtp.gmail.com with ESMTPSA id p10-20020a170907910a00b00a26aaa47cc0sm166290ejq.129.2023.12.21.00.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 00:52:19 -0800 (PST)
Message-ID: <023377a7f227f8cd7d5eb73017dbe3f691b29b17.camel@redhat.com>
Subject: Re: [PATCH v3 net 0/4] qbv cycle time extension/truncation
From: Paolo Abeni <pabeni@redhat.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, Faizal Rahim
	 <faizal.abdul.rahim@linux.intel.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Thu, 21 Dec 2023 09:52:18 +0100
In-Reply-To: <20231219165650.3amt4ftyt7gisz47@skbuf>
References: <20231219081453.718489-1-faizal.abdul.rahim@linux.intel.com>
	 <20231219165650.3amt4ftyt7gisz47@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-12-19 at 18:56 +0200, Vladimir Oltean wrote:
> How are you testing the behavior, and who reported the issues / what prom=
pted
> the changes? Honestly I'm not very confident in the changes we're
> pushing down the linux-stable pipe. They don't look all that obvious, so
> I still think that having selftests would help.

I agree with Vladimir, this looks quite a bit too complex for a net fix
at this late point of the cycle. Given the period of the year, I think
it could be too late even for net-next - for this cycle.

It would be great if you could add some self-tests.

@Faizal: I understand your setup is quite complex, but it would be
great if you could come-up with something similar that could fit=20
tools/testing/selftests/net

Thanks!

Paolo


