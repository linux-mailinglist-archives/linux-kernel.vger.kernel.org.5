Return-Path: <linux-kernel+bounces-13819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9FD8212E3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 04:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 746EA28284F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 03:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B116BA52;
	Mon,  1 Jan 2024 03:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a42qvMKy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC02803;
	Mon,  1 Jan 2024 03:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2044d093b3fso5536279fac.3;
        Sun, 31 Dec 2023 19:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704078738; x=1704683538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u7GvQd+qHdmtATzJklO2uLLq2EMXX40HqpmDmkw+3xc=;
        b=a42qvMKyW+XoKvvIpgdgdZPtfQt26VuYTi9XQjfghrnwfdxP2iSqu04mw6woyQXi/Q
         0pr4uVDjDgbM6qOnS+5/HiVCbL8+9CuuvUk5JMx0vYum9hfBO/ZsIIzo9tduNyiOHt4n
         L3TfRGeSSwA+993w6ApDcuTj71YHSdm/mSiaAUNPtCUmXpeOM3KWkogqBR+guKc2pRYp
         3OVkoAUwSAKgw48xc9A2F+JDfRX5vsKKUXfEVoBeV8DsD7ATiLn4LBj2OLuK2ar2Wlnr
         dJephnPRtQFOVK6VvkL9Gb9bzw17CURuq4PDTtdNHZn12fbWK0EcQLmAVISdm5bscDXs
         3fqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704078738; x=1704683538;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u7GvQd+qHdmtATzJklO2uLLq2EMXX40HqpmDmkw+3xc=;
        b=nw/kNM6DUDCBjWPE9vBf6TeEulEuY4kg0tBb8+KcYwiLxcdzwdPGh8e6G2LVJAzPQk
         qd6ISr4qx9leADfmpLNohFfxdNGCMg/8H7//hTEbKeEAd2a1UHw+6MUMMC67ONsC6UyP
         3pNZGyjrmjPqA89rJiGF3wKD/vH6cxG+R3CPkayVvkURDswqT4kWi7zHsuuGpIo0OH3+
         lJUGmJ8ZOmDLsoqVhXpTC4cToeAiUGumNXwJBkShqXwoRdNXfZYzWhyFhk2k+j0HhwSi
         3CGyGfN9dQh9nBeSsGnwSwdtYzjlUAf2MtgZvtr/rQF52Uo/jBdeb+SBvN2UTu0YxkDq
         hPrw==
X-Gm-Message-State: AOJu0YwO7E0rWJ4rMILdFvrx/cw76hwAgHlZiTShwWOeU53n8/M8Zzoa
	/Ku2Ay8kbDnwH9GfpXvQlks=
X-Google-Smtp-Source: AGHT+IHQ+OiL9S5Ow8z8Ds9CB3HJTSLmax8kYcY2mrz/LWBaOfNiMH1YtKidYuTf8kt4QMLxMbVIjA==
X-Received: by 2002:a05:6871:60e:b0:203:b5ec:ef08 with SMTP id w14-20020a056871060e00b00203b5ecef08mr18560864oan.107.1704078738325;
        Sun, 31 Dec 2023 19:12:18 -0800 (PST)
Received: from [10.0.2.15] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id cb5-20020a056a02070500b005ce170c797bsm10975835pgb.87.2023.12.31.19.12.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Dec 2023 19:12:17 -0800 (PST)
Message-ID: <4b2d4c62-135d-4d25-8a3a-2fabd996c980@gmail.com>
Date: Mon, 1 Jan 2024 12:12:16 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: Raise the minimum Sphinx requirement to 2.4.4
To: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Akira Yokosawa <akiyks@gmail.com>
References: <874jgs47fq.fsf@meer.lwn.net>
 <50830030-dca7-4c43-bcc8-449c7cfa9fbb@gmail.com>
 <87sf43qxzt.fsf@meer.lwn.net>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <87sf43qxzt.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On Fri, 15 Dec 2023 08:36:06 -0700, Jonathan Corbet wrote:
> Akira Yokosawa <akiyks@gmail.com> writes:
> 
>> With this patch applied, I get a confusing looking warning from
>> "make htmldocs" on a machine where the Sphinx version is 2.4.5:
>>
>> --------
>> Warning: It is recommended at least Sphinx version 3.4.3.
>> To upgrade Sphinx, use:
>>
>> 	/home/akira/sphinx-2.4.5/bin/python3 -m venv sphinx_2.4.4
>> 	. sphinx_2.4.4/bin/activate
>> 	pip install -r ./Documentation/sphinx/requirements.txt
>>
>>     If you want to exit the virtualenv, you can use:
>> 	deactivate
>> --------
>>
>> Looks like we need to update requirements.txt as well so that it
>> installs Sphinx 3.4.3.  Appended below is a fixup patch to that
>> effect.
> 
> So I can apply this, certainly, but it makes me feel like perhaps we
> need to reconsider our approach a bit.  It's kind of weird that we have
> a minimum supported version, then a semi-random "recommended" version
> that is still pretty old.
> 
> Is there a reason to suggest to people that they should run something
> other than current sphinx, especially if they are updating it anyway?
> So our "recommended version" is really "recommended *minimum* version"?

I picked 3.4.3 just because it is the version of distro Sphinx on
debian 11 and RHEL 9.  It works just fine and "make htmldocs" should
not complain it as not-recommended.

In sphinx-pre-install, "recommended version", aka $rec_version, works
as a criteria to emit upgrade suggestion.

That said, I think it should be OK if "pip install -r requirements.txt"
installs a newer version.

>
> 
>> ----8<----
>> From: Akira Yokosawa <akiyks@gmail.com>
>> Subject: [PATCH] docs: sphinx/requirement.txt: Reflect recommended Sphinx version
>>
>> sphinx_pre_install parses the version of Sphinx in requirements.txt
>> and emits messages based on it.
>> Update requirements.txt so that it installs Sphinx 3.4.3, as well as
>> the examples in documentation.
>>
>> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
>> ---
>>  Documentation/doc-guide/sphinx.rst    | 14 +++++++-------
>>  Documentation/sphinx/requirements.txt |  4 +++-
>>  2 files changed, 10 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
>> index 3d125fb4139d..5227a2611026 100644
>> --- a/Documentation/doc-guide/sphinx.rst
>> +++ b/Documentation/doc-guide/sphinx.rst
>> @@ -48,13 +48,13 @@ or ``virtualenv``, depending on how your distribution packaged Python 3.
>>        on the Sphinx version, it should be installed separately,
>>        with ``pip install sphinx_rtd_theme``.
>>  
>> -In summary, if you want to install Sphinx version 2.4.4, you should do::
>> +In summary, if you want to install Sphinx version 3.4.3, you should do::
>>  
>> -       $ virtualenv sphinx_2.4.4
>> -       $ . sphinx_2.4.4/bin/activate
>> -       (sphinx_2.4.4) $ pip install -r Documentation/sphinx/requirements.txt
>> +       $ virtualenv sphinx_3.4.3
>> +       $ . sphinx_3.4.3/bin/activate
>> +       (sphinx_3.4.3) $ pip install -r Documentation/sphinx/requirements.txt
> 
> Here we could take version numbers out entirely; otherwise we'll always
> be updating this.

I thing this should be a verbatim copy of message from sphinx_pre_install
presented later in sphinx.rst.

> 
>> -After running ``. sphinx_2.4.4/bin/activate``, the prompt will change,
>> +After running ``. sphinx_3.4.3/bin/activate``, the prompt will change,
>>  in order to indicate that you're using the new environment. If you
>>  open a new shell, you need to rerun this command to enter again at
>>  the virtual environment before building the documentation.
>> @@ -118,8 +118,8 @@ command line options for your distro::
>>  	You should run:
>>  
>>  		sudo dnf install -y texlive-luatex85
>> -		/usr/bin/virtualenv sphinx_2.4.4
>> -		. sphinx_2.4.4/bin/activate
>> +		/usr/bin/virtualenv sphinx_3.4.3
>> +		. sphinx_3.4.3/bin/activate
>>  		pip install -r Documentation/sphinx/requirements.txt
>>  
>>  	Can't build as 1 mandatory dependency is missing at ./scripts/sphinx-pre-install line 468.
>> diff --git a/Documentation/sphinx/requirements.txt b/Documentation/sphinx/requirements.txt
>> index 335b53df35e2..89329e67e788 100644
>> --- a/Documentation/sphinx/requirements.txt
>> +++ b/Documentation/sphinx/requirements.txt
>> @@ -1,3 +1,5 @@
>>  # jinja2>=3.1 is not compatible with Sphinx<4.0
>>  jinja2<3.1
>> -Sphinx==2.4.4
>> +# docutils>=0.18 is not compatible with 3.0 <= Sphinx < 4.0
>> +docutils<0.18
>> +Sphinx==3.4.3
> 
> I'd forgotten about the docutils fun.  I wonder of our recommended
> minimum should actually be 4.0, then here we could put simply:
> 
>   Sphinx>4.0

I tried it and "make htmldocs" complains:

    Can't get default sphinx version from ./Documentation/sphinx/requirements.txt at ./scripts/sphinx-pre-install line 305.
    make[2]: *** [Documentation/Makefile:101: htmldocs] Error 255
    make[1]: *** [/home/akira/git/linux/Makefile:1695: htmldocs] Error 2
    make: *** [Makefile:234: __sub-make] Error 2

I did try to remedy this, but realized that I was too frustrated in
deciphering the script to come up with a reasonable update.

I'm giving up on this.

Sorry about that.

Regards,
Akira

> 
> ?
> 
> Thanks,
> 
> jon


