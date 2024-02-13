Return-Path: <linux-kernel+bounces-64039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A86853940
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A46D1F24189
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F58605C9;
	Tue, 13 Feb 2024 17:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="NgDeUBF9"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A007C604D6;
	Tue, 13 Feb 2024 17:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707847024; cv=none; b=fkyusORyI3iAqUMMUdBf6CCcVTJQ++CKOqoGuyKXUfKXKupqNwqwFogiYeXaNtrkYS4Ko778dEwJeku8y0C+lb+kmjXLRDvm5L7z5C/e7iblJ1pRPpptdU6oHS1nqMuV9g6Gjh+6SVbv7sUv8O+nJBEk1NUe+aad2kYRrRfZn2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707847024; c=relaxed/simple;
	bh=ZfGvzDCTe9a+DFtINWX17OrD88EuGKTt6NUPw5nB0LE=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=uwUSJsemjja+Gh8Z+nya/lR9Cqy89GAfPHPhMcfC5tdRvb51Tu0Z8e/2DadtgURa3OriF4wgN/8ddQHJnMmZ6mYvgGPuTb5nIg7bV9covkYVa2fbQ/VF7OmIWkzlFDsFtsgQnKng/tEPiD8ZvS6pQiWvKXHtRS0iVJxpdM2leG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=NgDeUBF9; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707847019; x=1708451819; i=rwarsow@gmx.de;
	bh=ZfGvzDCTe9a+DFtINWX17OrD88EuGKTt6NUPw5nB0LE=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
	b=NgDeUBF9xCP4apaBzBYGm5iDyuAp1yr1CHpRvs9/UIV8GN8ZvBT6iV3uUcwZk52F
	 Vu/HM9sQ844mGrqNVuiznelHO+u9Pl+68+5LzYsEI42GODFMre9WcKFzNZxRorCdo
	 odAtFlGSDKpFbLpCfNqe+oRowV1xIMHPp75i5SMtV3WV/n076TnHWqj5pcI/rbkaP
	 QH5tUR5Ax5KDVPAGmZ5i2TTpgLT5KWMAXm9I5Lbw/GP5oMV2aRCqeVSsNbdnT4KO8
	 uP9aPU3i4TGH2GZcDOQ0CxQf7bUHNtg7H7l+Idj5SyF/Ms+Q+aeg0td3qn2lXRzQj
	 9UEFNdJAANi+hvs0QQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.32.74]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7K3Y-1rdFsl08fE-007pG5; Tue, 13
 Feb 2024 18:56:59 +0100
Message-ID: <44295870-24ff-46c3-9c4c-30eb83ca178c@gmx.de>
Date: Tue, 13 Feb 2024 18:56:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ronald Warsow <rwarsow@gmx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.7 000/124] 6.7.5-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:CaH4zo7vm23UZUWQP0BforgngbfSbDA4mtKLxy5jm55Sj7AKnzB
 fnHznHPa5R+qYgCLPFPQBENcPUPSwre8tvkBpDGq599RJG2npo0w4MLEUIEu8YXFyJUl9/J
 cx7ng3HNtkFAmguPuc8xmCxuGUb5R7tjhT1Xy2mfO5ZLMpACdsnAmzSRLEU32x5gw9XZai1
 ++wuPTBImRSZFaQpdN0vQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kmTuslMsvi4=;e1PjQULZcocIW1GCnfuUpRXzgax
 hwqBaxtd24jkGOfWbYH2cDoB3bd53wi1N9IdJTt8pN0n4Sx1gOp630RVY3f+tTMngnL33SWfH
 iyYmzfZ7bxYaEbYOpj1n9TilTwtikqg0xWUPlM7mhVSfH8lT23h4NuXYDeri3pREvafQ4W2If
 z2uskhjGrl0fM452Ag+rbFXh+B83QHNgjbmr+ydlZ23TnxtN4Trrj7EWUCoSH6aI0SG3kx9Xp
 Y+RjfPiwfWCzSAyvbofjXIlfDDkw7ynxSK2cnZTMjBsQwq40V4ZxZ9D7iHmtbbD+N7qDEWvb+
 0cqm/5/eRnICQG5z6rxqrpBJNUDrnErChB+HdNNpt7cKkNdWsT9F+i1fEbm6+FKoqFSJsH+n0
 wo579ay8vBljKkNeEew9SoEtJjcyd2OtjbG4FXFfStoYhFUfaWkXag3Q+YqRn7e+06R+N47h4
 6+nYoJNNExR1zOCMeAOzm8/LdkZ+ndKarj/xDt2wCsuXiAIghB7g6Ou7aQlwyijhUHlsCD7CJ
 c9+I+6h1fxsj7g+NOQqN5l5UbQCnAyxLnlsms0iM4gUrs/xjoTXrjayhNdqpLxWIJYN7ULbmH
 AeP0OVsF7MLh0cS+c5TP8oMh2n1va2HmFKMzjyM8M4/ENjMzMTeOexsFxWJyFnb2wSAS/+PCk
 vZ6Ty7asgKSZWTRiFYB4BYd1XhxfN6j+Os+1qyaa2mfW6OyjGnL2BiRuyscUOoH5cZmd8OVhA
 SIBCK5UeZ0D251jq+F3U7noHu4b28X0jKEYvxBvOmsLPxRZi7CWEtRIQp1oX+NPVgapXqPh+l
 5Lu6++WZOSpDd74cHF6HgqnFHtqcUSmcRqgRAZuZ4edBU=

Hi Greg

*no* regressions here on x86_64 (RKL, Intel 11th Gen.CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


