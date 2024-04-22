Return-Path: <linux-kernel+bounces-152689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 295E58AC2DC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 04:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D42AC281332
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 02:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8465C99;
	Mon, 22 Apr 2024 02:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNvElwTI"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B654C66;
	Mon, 22 Apr 2024 02:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713754538; cv=none; b=X0Bx3ufDUZ9KrV4hF3E0ckxRdqtLjOrBsZ1roC6jZCKHRpEMktQx7+gMRiw3US0+71KibWjzidgD+jjuGgI/kcCioTlTpAnZsb4tDi6PqXjcmmJQL+CCzjGRkedLs9fxDlALf/WJI2j2zUEJN/Z3DHrLDh+a546gkWsEUDkaV9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713754538; c=relaxed/simple;
	bh=9n6w5ATUmjmeghEVa4N63WO5dn+k6W+lDyQNxNzB1vM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sBqBL9YaSN+lQT05MOYeh1fnvAMlHCr9VZSZhiS5MfgROJaiBn+vH6AN2ra8uPBGOIkoG2ip36FwN2fvQJtDS7NTSX94ECLFNfReBAS9gmp8DYfar0sOKkc+dXIKMWRhTNXqyr/fO539tEaHKRJcs/EesnXv/mseU05PAV25NCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNvElwTI; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e2c725e234so37074135ad.1;
        Sun, 21 Apr 2024 19:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713754536; x=1714359336; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U8pqIPc4EG6QlT+nqkhKSSvUS1IxFCwklWgBWbz0VQM=;
        b=BNvElwTI01stmPHJ4UK5mJ77teh3wSQJk6R6+uxPaIMnXxrB0YK1gOAKkeNuBFfgDj
         H6UGj2Fs4e73iJJg9fWv20V+aGBz+BSvPFjaYvzIi10f5wtDNnI25s+HAZqFxC6mo59v
         of1hrOvNeoeqNcLTNhPiqSjYIvwt5YOKObZZ+h2xXzEkXVcmYoNP0f+g8hyd/32r1RvU
         2c9l8PZG2t1SD4x6DMl9sX9KrTt+NtIHMsgiOm48xZaN/8E8zEudFdm9H7q5WOZ4Td/c
         PMtFhcFAhhnFQSlb2U3lPAH6gTp9HKCPUIw3gxDIShQeB1eb4mW2hd0AgIVl/p2Pg367
         1pYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713754536; x=1714359336;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U8pqIPc4EG6QlT+nqkhKSSvUS1IxFCwklWgBWbz0VQM=;
        b=cdOr2ch1giOqcISbiUAoLBtmZ0GXCyakE66QLfPELhDt+dacSFwX3OnOATN+nm2TZA
         AOJrewcYhzhMWFMzKEhxJDeJyywFqT2IMl1LofSof/vIe+F1Zg8EEr7JJeGz2gJci2/x
         Tz+FYiXMcHAltJcqHBxM/aQPTIKbCoN7vE04R4/4o8c/LjKWQi7+OaZbdDhDLczHRs28
         v2MFZCOMmZtdxRXzg2cWRiB9IrDv22GBTxDfEsrWaNDd7lauLs+u0Zk/UN4KeohIRsmt
         24+XZ10RHLEmUYQdzpq5W4YVlGdAnMI8UtMKAdEuIQzZmWdlmPZXObY3z94sCXLT/8Bn
         z1KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoZteiapYWGuQsCIab09QLy0/GJA1Z/SaBzHLc52GuhrhPdC/Iv+I0aGSovb8N6TRBkFc0EChvoZS5/Zrv8KCdcEeyL8mqqN1vt+6L
X-Gm-Message-State: AOJu0YzjmL9BcBuzQKxkvnhsUtN2Cqj20wcUJmwAIPQ+7ntEibbuwG1L
	anTpNLBk6CI3DM8iqQMTLowWhnIiSMudEmVh69rWoK6kPltQe86S
X-Google-Smtp-Source: AGHT+IEqNWSVBCR1ttlkkzoGUyRGas4GYfaKaak8GKskFy0+4+ZMekuNqjOyvUIUrIplzsWCbdhD7g==
X-Received: by 2002:a17:902:a50c:b0:1e2:36d1:33fd with SMTP id s12-20020a170902a50c00b001e236d133fdmr13536562plq.27.1713754536083;
        Sun, 21 Apr 2024 19:55:36 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902edc400b001e29c4b7bd2sm6968374plk.240.2024.04.21.19.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 19:55:35 -0700 (PDT)
Message-ID: <ae157b64-67c2-422f-9025-86c3b9900f5e@gmail.com>
Date: Mon, 22 Apr 2024 10:55:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] docs/zh_CN: add process/cve Chinese translation
To: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>, Jonathan Corbet <corbet@lwn.net>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240419105713.2427146-1-dzm91@hust.edu.cn>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <20240419105713.2427146-1-dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/19/24 6:56 PM, Dongliang Mu wrote:
> Translate process/cve.rst into Chinese and add it to
> Documentation/translations/zh_CN directory.
> 
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
> v2->v3: remove a trailing space
> v1->v2: add a newline at then end of cve.rst.  
>  .../translations/zh_CN/process/cve.rst        | 89 +++++++++++++++++++
>  .../translations/zh_CN/process/index.rst      |  1 +
>  2 files changed, 90 insertions(+)
>  create mode 100644 Documentation/translations/zh_CN/process/cve.rst
> 
> diff --git a/Documentation/translations/zh_CN/process/cve.rst b/Documentation/translations/zh_CN/process/cve.rst
> new file mode 100644
> index 000000000000..b4e25cd52a3a
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/process/cve.rst
> @@ -0,0 +1,89 @@
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/process/cve.rst
> +:Translator: Dongliang Mu <dzm91@hust.edu.cn>
> +
> +====
> +CVEs
> +====
> +
> +Common Vulnerabilities and Exposure (CVE®) 编号是一种明确的方式来
> +识别、定义和登记公开披露的安全漏洞。随着时间的推移，它们在内核项目中的实用性
> +已经下降，CVE编号经常以不适当的方式和不适当的原因被分配。因此，内核开发社区
> +倾向于避免使用它们。然而，分配CVE与其他形式的安全标识符的持续压力，以及内核
> +社区之外的个人和公司的持续滥用，已经清楚地表明内核社区应该控制这些CVE分配。
> +
> +Linux内核开发团队确实有能力为潜在的Linux内核安全问题分配CVE。CVE的分配
> +独立于 :doc:`安全漏洞报送流程</process/security-bugs>`。
> +
> +所有分配给Linux内核的CVE列表都可以在linux-cve邮件列表的存档中找到，如
> +https://lore.kernel.org/linux-cve-announce/ 所示。如果想获得已分配
> +CVE的通知，请“订阅”该邮件列表。要获得分配的CVE通知，请订阅该邮件列表：
> +`subscribe <https://subspace.kernel.org/subscribing.html>`_。

s/subscribe/订阅/

> +
> +过程
> +=======
> +
> +作为正常稳定发布过程的一部分，可能存在安全问题的内核更改由负责CVE编号分配
> +的开发人员识别，并自动为其分配CVE编号。这些CVE分配会作为经常性的通告经常
> +发布在linux-cve-announce邮件列表上。
> +
> +注意，由于Linux内核在系统中的特殊地位，几乎任何漏洞都可能被利用来危害内核
> +的安全性，但是当漏洞被修复后，利用的可能性通常不明显。因此，CVE分配团队过于
> +谨慎，并将CVE编号分配给他们识别的任何漏洞修复。这就解释了为什么Linux内核
> +团队会发布大量的CVE。
> +
> +如果CVE分配团队错过了任何用户认为应该分配CVE的特定修复，请发送电子邮件到
> +<cve@kernel.org>，那里的团队将与您一起工作。请注意，任何潜在的安全问题
> +不应被发送到此邮箱，它仅用于为已发布的内核树中的漏洞修复分配CVE。如果你觉得
> +自己发现了一个未修复的安全问题，请按照 :doc:`安全漏洞报送流程
> +</process/security-bugs>` 发送到Linux内核社区。
> +
> +Linux内核不会给未修复的安全问题自动分配CVE；只有在安全修复可用且应用于
> +稳定内核树后，CVE分配才会自动发生，并且它将通过安全修复的Git提交编号进行
> +跟踪。如果有人希望在提交安全修复之前分配CVE，请联系内核CVE分配团队，从
> +他们的一批保留编号中获得相应的CVE编号。
> +
> +对于目前没有得到稳定与长期维护内核团队积极支持的内核版本中发现的任何问题，
> +都不会分配CVEs。当前支持的内核分支列表可以在 https://kernel.org/releases.html
> +上找到。
> +
> +被分配CVE的争论
> +=========================
> +
> +对于为特定内核修改分配的CVE，其争论或修改的权限仅属于受影响子系统的维护者。
> +这一原则确保了漏洞报告的高度准确性和可问责性。只有那些具有深厚专业知识和
> +对子系统深入了解的维护人员，才能有效评估内核漏洞的有效性和范围，并确定其适当的
> +CVE指定策略。在此指定权限之外，任何争论或修改CVE的尝试都可能导致混乱、
> +不准确的报告，并最终危及系统。
> +
> +无效的CVE
> +============
> +
> +如果发现的安全问题存在于仅由某Linux发行版支持的Linux内核中，即安全问题是
> +由于Linux发行版所做的更改导致，或者Linux的发行版内核版本不再是Linux内核
> +社区支持的内核版本，那么Linux内核CVE团队将不能分配CVE，必须从Linux
> +发行版本身请求。
> +
> +内核CVE分配团队以外的任何团队对Linux内核支持版本分配的CVE都不应被
> +视为有效CVE。请通知内核CVE分配团队，以便他们可以通过CNA修复过程使
> +这些条目失效。

"通过CNA修复过程使这些条目失效", 这里的过程是不是可以换成其他名词更好？
例如'措施'
> +
> +特定CVE的适用性
> +==============================
> +
> +由于Linux内核可以以许多不同方式使用，外部用户可以通过许多不同方式访问它，或者
> +根本没有访问，因此任何特定CVE的适用性取决于Linux用户，而不是内核CVE分配团队。
> +请不要与我们联系来尝试确定任何特定CVE的适用性。
> +
> +此外，由于源代码树非常大，而任何一个系统都只使用源代码树的一小部分，因此任何
> +Linux用户都应该意识到，大量分配的CVEs与他们的系统无关。
> +
> +简而言之，我们不知道您的用例，也不知道您使用的是内核的哪个部分，因此我们无法
> +确定特定的CVE是否与您的系统相关。
> +
> +与往常一样，最好采取所有发布的内核更改，因为它们是由许多社区成员在一个统一的
> +整体中一起进行测试的，而不是作为个别的精选更改。还要注意，对于许多安全问题来
> +说，整体问题的解决方案并不是在单个更改中找到的，而是在彼此之上的许多修复的总
> +和。理想情况下，CVE将被分配给所有问题的所有修复，但有时我们将无法注意到一些
> +修复，因此某些修复可能在没有CVE的情况下被采取。

s/采取/采用/

for others
Reviewed-by: Alex Shi <alexs@kernel.org>

> diff --git a/Documentation/translations/zh_CN/process/index.rst b/Documentation/translations/zh_CN/process/index.rst
> index 3ca02d281be0..5c6c8ccdd50d 100644
> --- a/Documentation/translations/zh_CN/process/index.rst
> +++ b/Documentation/translations/zh_CN/process/index.rst
> @@ -48,6 +48,7 @@ TODOLIST:
>     :maxdepth: 1
>  
>     embargoed-hardware-issues
> +   cve
>  
>  TODOLIST:
>  

