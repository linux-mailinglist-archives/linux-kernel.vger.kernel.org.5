Return-Path: <linux-kernel+bounces-102619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B835187B4A5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBDAE1C2144D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C7C5D72B;
	Wed, 13 Mar 2024 22:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Oo1BkIWf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B085A0EB;
	Wed, 13 Mar 2024 22:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710370342; cv=none; b=nfb/qfDFBGCwNQY+vCMhszt0YijKy75mXyk1QMc7824sDKDih+9A7kR7IL28pFby67nANAn9H4PcqRlU49655eoYhGhWeKxADKM5r/OO5NTjUMdTV6h2uN7raW+hjtoUcY2fPqvS8+eo4WfGpCUUfzKLepRxaq4OJD48jYUeR/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710370342; c=relaxed/simple;
	bh=2HTUB6/xaI3gevTSl8qBS2gA7J94MLFpCqKyqXxHdvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Zbh87a2DYO1BGkZ6iTEdW6veST/3LnLjXhLpFlRIvBdUqNxbHy28dEFHfnA9ohKbURnl12yc3YpMEZahXIRVfa4lLP+Cdnkd8Vn18zURT2SD2HSqmyKjpG9MNdeiWmXkOBv7d4Owco/dAGdRwI6f/iz0b9q40rN9gYfh4lDAJ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Oo1BkIWf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42DLvbOk027157;
	Wed, 13 Mar 2024 22:51:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=jMWRMbYIZO6Y6crhunSlTLQWHGSrabz5NP2clR8Lzyg=; b=Oo
	1BkIWfF5BgnNE5erj2KzvK5P+JuEwBGFIvCrt1oZmJouOaIkAt/ut4+LkTvha3ZY
	zcitRhWsD989nVr1OvjtDHsMLidGPFkLsBITSxc2c8A4cs3wOcCGSoUWbMywpFCW
	BXQSK0AUS5kORIAatZgMPoIozG9E3andaAWyv0eJzJBrfvN5+ktshIqcBkk94eGE
	9AZWlhJMNvsCQ447ZIdIRrvB9K5No+1iyFVhoIRQjsybcDR477Hltjb5QvJ5FFIN
	V9UHH5twxJHdSX6w3R6pMufWGdywphC6pZng0+mYDtaEVbvP5vgHGYhMW43xd0PG
	HpDwtkwNhbVGoFrp5ffg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wu9xaspgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 22:51:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42DMpCRs004527
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 22:51:12 GMT
Received: from [10.110.27.195] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 13 Mar
 2024 15:51:11 -0700
Message-ID: <f0492c92-1015-48e3-bfce-598c7a4843d1@quicinc.com>
Date: Wed, 13 Mar 2024 15:51:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Re: [PATCH] crypto: pkcs7: remove sha1 support
Content-Language: en-US
To: Eric Biggers <ebiggers@kernel.org>, James Prestwood <prestwoj@gmail.com>
CC: Johannes Berg <johannes@sipsolutions.net>, Karel Balej <balejk@matfyz.cz>,
        <dimitri.ledkov@canonical.com>, <alexandre.torgue@foss.st.com>,
        <davem@davemloft.net>, <dhowells@redhat.com>,
        <herbert@gondor.apana.org.au>, <keyrings@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-modules@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>, <mcgrof@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>, <iwd@lists.linux.dev>
References: <CZSHRUIJ4RKL.34T4EASV5DNJM@matfyz.cz>
 <005f998ec59e27633b1b99fdf929e40ccfd401c1.camel@sipsolutions.net>
 <f2dcbe55-0f0e-4173-8e21-f899c6fc802a@gmail.com>
 <20240313194423.GA1111@sol.localdomain>
 <b838e729-dc30-4e18-b928-c34c16b08606@gmail.com>
 <20240313202223.GB1111@sol.localdomain>
 <db86cba4-0e61-441d-8e66-405a13b61a3c@gmail.com>
 <20240313221043.GC1111@sol.localdomain>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240313221043.GC1111@sol.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EQ1oBcAKVVr6392XzSXRR2wEAfpYrNcm
X-Proofpoint-GUID: EQ1oBcAKVVr6392XzSXRR2wEAfpYrNcm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_09,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 impostorscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403130174

On 3/13/2024 3:10 PM, Eric Biggers wrote:
> On Wed, Mar 13, 2024 at 02:17:29PM -0700, James Prestwood wrote:
>> Hi,
>>
>> On 3/13/24 1:22 PM, Eric Biggers wrote:
>>> On Wed, Mar 13, 2024 at 01:12:54PM -0700, James Prestwood wrote:
>>>> Hi,
>>>>
>>>> On 3/13/24 12:44 PM, Eric Biggers wrote:
>>>>> On Wed, Mar 13, 2024 at 10:26:06AM -0700, James Prestwood wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 3/13/24 1:56 AM, Johannes Berg wrote:
>>>>>>> Not sure why you're CC'ing the world, but I guess adding a few more
>>>>>>> doesn't hurt ...
>>>>>>>
>>>>>>> On Wed, 2024-03-13 at 09:50 +0100, Karel Balej wrote:
>>>>>>>>     and I use iwd
>>>>>>> This is your problem, the wireless stack in the kernel doesn't use any
>>>>>>> kernel crypto code for 802.1X.
>>>>>> Yes, the wireless stack has zero bearing on the issue. I think that's what
>>>>>> you meant by "problem".
>>>>>>
>>>>>> IWD has used the kernel crypto API forever which was abruptly broken, that
>>>>>> is the problem.
>>>>>>
>>>>>> The original commit says it was to remove support for sha1 signed kernel
>>>>>> modules, but it did more than that and broke the keyctl API.
>>>>>>
>>>>> Which specific API is iwd using that is relevant here?
>>>>> I cloned https://kernel.googlesource.com/pub/scm/network/wireless/iwd
>>>>> and grepped for keyctl and AF_ALG, but there are no matches.
>>>> IWD uses ELL for its crypto, which uses the AF_ALG API:
>>>>
>>>> https://git.kernel.org/pub/scm/libs/ell/ell.git/
>>> Thanks for pointing out that the relevant code is really in that separate
>>> repository.  Note, it seems that keyctl() is the problem here, not AF_ALG.  The
>>> blamed commit didn't change anything for AF_ALG.
>>>
>>>> I believe the failure is when calling:
>>>>
>>>> KEYCTL_PKEY_QUERY enc="x962" hash="sha1"
>>>>
>>>>  From logs Michael posted on the IWD list, the ELL API that fails is:
>>>>
>>>> l_key_get_info (ell.git/ell/key.c:416)
>>> Okay, I guess that's what's actually causing the problem.  KEYCTL_PKEY_* are a
>>> weird set of APIs where userspace can ask the kernel to do asymmetric key
>>> operations.  It's unclear why they exist, as the same functionality is available
>>> in userspace crypto libraries.
>>>
>>> I suppose that the blamed commit, or at least part of it, will need to be
>>> reverted to keep these weird keyctls working.
>>>
>>> For the future, why doesn't iwd just use a userspace crypto library such as
>>> OpenSSL?
>>
>> I was not around when the original decision was made, but a few reasons I
>> know we don't use openSSL:
>>
>>  - IWD has virtually zero dependencies.
> 
> Depending on something in the kernel does not eliminate a dependency; it just
> adds that particular kernel UAPI to your list of dependencies.  The reason that
> we're having this discussion in the first place is because iwd is depending on
> an obscure kernel UAPI that is not well defined.  Historically it's been hard to
> avoid "breaking" changes in these crypto-related UAPIs because of the poor
> design where a huge number of algorithms are potentially supported, but the list
> is undocumented and it varies from one system to another based on configuration.
> Also due to their obscurity many kernel developers don't know that these UAPIs
> even exist.  (The reaction when someone finds out is usually "Why!?")
> 
> It may be worth looking at if iwd should make a different choice for this
> dependency.  It's understandable to blame dependencies when things go wrong, but
> at the same time the choice of dependency is very much a choice, and some
> choices can be more technically sound and cause fewer problems than others...
> 
>>  - OpenSSL + friends are rather large libraries.
> 
> The Linux kernel is also large, and it's made larger by having to support
> obsolete crypto algorithms for backwards compatibility with iwd.
> 
>>  - AF_ALG has transparent hardware acceleration (not sure if openSSL does
>> too).
> 
> OpenSSL takes advantage of CPU-based hardware acceleration, e.g. AES-NI.
> 
>> Another consideration is once you support openSSL someone wants wolfSSL,
>> then boringSSL etc. Even if users implement support it just becomes a huge
>> burden to carry for the project. Just look at wpa_supplicant's src/crypto/
>> folder, nearly 40k LOC in there, compared to ELL's crypto modules which is
>> ~5k. You have to sort out all the nitty gritty details of each library, and
>> provide a common driver/API for the core code, differences between openssl
>> versions, the list goes on.
> 
> What is the specific functionality that you're actually relying on that you
> think would need 40K lines of code to replace, even using OpenSSL?  I see you
> are using KEYCTL_PKEY_*, but what specifically are you using them for?  What
> operations are being performed, and with which algorithms and key formats?
> Also, is the kernel behavior that you're relying on documented anywhere?  There
> are man pages for those keyctls, but they don't say anything about any
> particular hash algorithm, SHA-1 or otherwise, being supported.

<https://lore.kernel.org/all/CA+55aFxW7NMAMvYhkvz1UPbUTUJewRt6Yb51QAx5RtrWOwjebg@mail.gmail.com/>
"And we simply do not break user space."
-Linus Torvalds

Is this no longer applicable?


