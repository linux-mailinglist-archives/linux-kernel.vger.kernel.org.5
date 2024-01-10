Return-Path: <linux-kernel+bounces-21581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F80C829173
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80AB02849C9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E275681F;
	Wed, 10 Jan 2024 00:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ClAXZTQc"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0DC383;
	Wed, 10 Jan 2024 00:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=9Z+eVnm12UxQBSd/stAX1lfcKTZHfLEybCIQDl9VjPg=; b=ClAXZTQcvmlytmHEW1rReNZPml
	406IseUvgxd35jLCH3XfSpR6DBkUgUfvGsmo93nhA5bSA8Qw1zESFFt11fJv+5ppab/7dC8aO+8zR
	D1qou94flnxgj7FOwLV64Ys4/Z1+iJe0iotMg1uD8t6rVK+9dIPkIToFkpE8k0ecYy5sxROe/9iLz
	snCfD2Nmbgb+wKPY3xL1LpJyOUtZRh8aLFCFYeWFnhsk4/zfHuJHmN+fBq2rAOpf3sr7B+PPjaVEE
	D17l8Kaqp0uwlL9QkbP00Rb6MB5OENEq+rVE0EKq+GJ6KUEhwGVo8bt6aZzig8XGVLIZxYz3BSwol
	GEJ44gzA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rNMVU-009xdu-07;
	Wed, 10 Jan 2024 00:31:44 +0000
Message-ID: <fbbac337-8414-4903-8a7d-5cb0b6d05282@infradead.org>
Date: Tue, 9 Jan 2024 16:31:42 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 01/34] docs: gunyah: Introduce Gunyah Hypervisor
Content-Language: en-US
To: Elliot Berman <quic_eberman@quicinc.com>, Alex Elder <elder@linaro.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Murali Nalajal <quic_mnalajal@quicinc.com>,
 Trilok Soni <quic_tsoni@quicinc.com>,
 Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
 Carl van Schaik <quic_cvanscha@quicinc.com>,
 Philip Derrin <quic_pderrin@quicinc.com>,
 Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
 Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Fuad Tabba
 <tabba@google.com>, Sean Christopherson <seanjc@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
References: <20240109-gunyah-v16-0-634904bf4ce9@quicinc.com>
 <20240109-gunyah-v16-1-634904bf4ce9@quicinc.com>
 <d5b041d9-1691-4259-a76c-176c5b3d8be3@infradead.org>
 <731ee7a9-72c8-4ae7-8fcd-2c9bb07b09ac@quicinc.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <731ee7a9-72c8-4ae7-8fcd-2c9bb07b09ac@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/9/24 16:28, Elliot Berman wrote:
> 
> 
> On 1/9/2024 3:31 PM, Randy Dunlap wrote:
>>
>>
>> On 1/9/24 11:37, Elliot Berman wrote:
>>> Gunyah is an open-source Type-1 hypervisor developed by Qualcomm. It
>>> does not depend on any lower-privileged OS/kernel code for its core
>>> functionality. This increases its security and can support a smaller
>>> trusted computing based when compared to Type-2 hypervisors.
>>>
>>> Add documentation describing the Gunyah hypervisor and the main
>>> components of the Gunyah hypervisor which are of interest to Linux
>>> virtualization development.
>>>
>>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>>> ---
>>>  Documentation/virt/gunyah/index.rst         | 134 ++++++++++++++++++++++++++++
>>>  Documentation/virt/gunyah/message-queue.rst |  68 ++++++++++++++
>>>  Documentation/virt/index.rst                |   1 +
>>>  3 files changed, 203 insertions(+)
>>>
>>> diff --git a/Documentation/virt/gunyah/index.rst b/Documentation/virt/gunyah/index.rst
>>> new file mode 100644
>>> index 000000000000..da8e5e4b9cac
>>> --- /dev/null
>>> +++ b/Documentation/virt/gunyah/index.rst
>>> @@ -0,0 +1,134 @@
>>> +.. SPDX-License-Identifier: GPL-2.0
>>> +
>>> +=================
>>> +Gunyah Hypervisor
>>> +=================
>>> +
>>> +.. toctree::
>>> +   :maxdepth: 1
>>> +
>>> +   message-queue
>>> +
>>> +Gunyah is a Type-1 hypervisor which is independent of any OS kernel, and runs in
>>> +a higher CPU privilege level. It does not depend on any lower-privileged
>>
>> Is this the usual meaning of higher and lower? Seems backwards to me.
>>
> 
> Hmm, I guess this x86 having ring 0 as most privileged and arm using EL3 as most
> privileged. I'll switch to "more" and "less" privilege rather than implying
> a numbering scheme.

I suspected that. Thanks for the change.

-- 
#Randy

