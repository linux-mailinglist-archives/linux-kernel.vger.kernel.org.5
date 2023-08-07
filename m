Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24D0771BE9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 09:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjHGH56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 03:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjHGH5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 03:57:53 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE8510F4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 00:57:51 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso3056124a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 00:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691395070; x=1691999870;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D0+El16bTvNcw/urulKH9USZzX07LPALBWhqGXhETFs=;
        b=SRAYhoJjs+iXD+Ja1EdVMeYNf8hDgdogWNtw5wOTeG4u/bjFvu5rZh5ng5scbULNha
         MvKy4wICUNSmNzkBSZun1BHJJq+PXpfxDf0oS2IZtmjKuDv0fpcPHqQQ4rdmckssnVYy
         jUg/RQJkfuR9CuqSf0Uhd0ytFKH/pMtfV4bPwz5pvsyqF5nqMMy+zzwbuMmpRtNITROU
         tTPprDGSrgjB5ZLR/KtTkHsNkDJaQhCCS/86t1VyVF0d/Wsy3MN1jt1vSQefJmY01+QY
         yc3F7Wa+vzy1dPFIh1Hn2RFTZt5BKPmgxD27spalPylqIvB8PLagcFh56FoXjHwNneKs
         gqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691395070; x=1691999870;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D0+El16bTvNcw/urulKH9USZzX07LPALBWhqGXhETFs=;
        b=BdwgDddVAjmadiMaFofoIUXzj4z2+r3AJol+oQSdRj6d/k5wjaRnVoWkUxSOXXnpE4
         TtvRfvhmLrNfooarDeZ2iRM9duvIsLFz67KsHImBiFxydqhOj8rfLxK69IMhAlMIsGvR
         dtScdbs3459I+aLkNehIURJDW6Uke9iDMRz2yGVmG+oHLds7fs2zvso6VBACZc8hlHfl
         h8rgTCj7oJOowutxgoJUER5sbLDGzP2R+2QiWnF2qiCOVue2kPTVRB+XveLpgAXFKqxS
         DxOVjtgcN2j8bRQpME+8wVPlwqX8kORYXtZ9fhDvXzPlSEy2YP1lEphr4WhynUgQTe3Y
         b9MA==
X-Gm-Message-State: AOJu0Yys9z8Zjb9TL2wjXIEhoPCUu7aPc8wKrB+gjO2dKBK/NdcnZL0G
        AsvLVku0LLmUzWjnk9rADoY=
X-Google-Smtp-Source: AGHT+IHLjGoIqkusV4s8qZxKrB1SVVmzX68bYiQfoC63MCXgKTze6FnIapjORPRqQG0fqJrxXVYIMQ==
X-Received: by 2002:a05:6a20:1399:b0:137:53d1:405 with SMTP id hn25-20020a056a20139900b0013753d10405mr9107304pzc.26.1691395070473;
        Mon, 07 Aug 2023 00:57:50 -0700 (PDT)
Received: from [192.168.0.101] ([49.207.242.210])
        by smtp.gmail.com with ESMTPSA id g13-20020aa7818d000000b0067777e960d9sm5521545pfi.155.2023.08.07.00.57.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 00:57:50 -0700 (PDT)
Message-ID: <a9cbd99b-b5ce-4666-a08a-5586af3158c7@gmail.com>
Date:   Mon, 7 Aug 2023 13:27:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/8] sign-file: inntroduce few new flags to make
 argument processing easy.
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org, nathan@kernel.org,
        ndesaulniers@google.com, nicolas@fjasle.eu,
        linux-kernel@vger.kernel.org, sshedi@vmware.com
References: <20230623145358.568971-1-yesshedi@gmail.com>
 <20230623145358.568971-3-yesshedi@gmail.com>
 <CAK7LNATPVv99Vzxt2M=FO6OOaBvs+DyZS2rni+-DLEPbAGGoFQ@mail.gmail.com>
Content-Language: en-US
From:   Shreenidhi Shedi <yesshedi@gmail.com>
In-Reply-To: <CAK7LNATPVv99Vzxt2M=FO6OOaBvs+DyZS2rni+-DLEPbAGGoFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/23 08:05, Masahiro Yamada wrote:
> On Fri, Jun 23, 2023 at 11:54 PM Shreenidhi Shedi <yesshedi@gmail.com> wrote:
>>
>> - Add some more options like help, x509, hashalgo to command line args
>> - This makes it easy to handle and use command line args wherever needed
>>
>> Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
>> ---
>>   scripts/sign-file.c | 63 ++++++++++++++++++++++++++++++++-------------
>>   1 file changed, 45 insertions(+), 18 deletions(-)
>>
>> diff --git a/scripts/sign-file.c b/scripts/sign-file.c
>> index 94228865b6cc..b0f340ea629b 100644
>> --- a/scripts/sign-file.c
>> +++ b/scripts/sign-file.c
>> @@ -215,6 +215,11 @@ static X509 *read_x509(const char *x509_name)
>>
>>   struct cmd_opts {
>>          char *raw_sig_name;
>> +       char *hash_algo;
>> +       char *dest_name;
>> +       char *private_key_name;
>> +       char *x509_name;
>> +       char *module_name;
>>          bool save_sig;
>>          bool replace_orig;
>>          bool raw_sig;
>> @@ -233,6 +238,12 @@ static void parse_args(int argc, char **argv, struct cmd_opts *opts)
>>   #ifndef USE_PKCS7
>>                  {"usekeyid",    no_argument,        0,  'k'},
>>   #endif
>> +               {"help",        no_argument,        0,  'h'},
>> +               {"privkey",     required_argument,  0,  'i'},
>> +               {"hashalgo",    required_argument,  0,  'a'},
>> +               {"x509",        required_argument,  0,  'x'},
>> +               {"dest",        required_argument,  0,  'd'},
>> +               {"replaceorig", required_argument,  0,  'r'},
>>                  {0, 0, 0, 0}
>>          };
>>
>> @@ -241,10 +252,10 @@ static void parse_args(int argc, char **argv, struct cmd_opts *opts)
>>
>>          do {
>>   #ifndef USE_PKCS7
>> -               opt = getopt_long_only(argc, argv, "pds:",
>> +               opt = getopt_long_only(argc, argv, "hpds:i:a:x:t:r:",
>>                                  cmd_options, &opt_index);
>>   #else
>> -               opt = getopt_long_only(argc, argv, "pdks:",
>> +               opt = getopt_long_only(argc, argv, "hpdks:i:a:x:t:r:",
>>                                  cmd_options, &opt_index);
>>   #endif
>>                  switch (opt) {
>> @@ -268,6 +279,30 @@ static void parse_args(int argc, char **argv, struct cmd_opts *opts)
>>                          break;
>>   #endif
>>
>> +               case 'h':
>> +                       format();
>> +                       break;
>> +
>> +               case 'i':
>> +                       opts->private_key_name = optarg;
>> +                       break;
>> +
>> +               case 'a':
>> +                       opts->hash_algo = optarg;
>> +                       break;
>> +
>> +               case 'x':
>> +                       opts->x509_name = optarg;
>> +                       break;
>> +
>> +               case 't':
>> +                       opts->dest_name = optarg;
>> +                       break;
>> +
>> +               case 'r':
>> +                       opts->replace_orig = true;
>> +                       break;
>> +
>>                  case -1:
>>                          break;
>>
>> @@ -281,9 +316,6 @@ static void parse_args(int argc, char **argv, struct cmd_opts *opts)
>>   int main(int argc, char **argv)
>>   {
>>          struct module_signature sig_info = { .id_type = PKEY_ID_PKCS7 };
>> -       char *hash_algo = NULL;
>> -       char *private_key_name = NULL;
>> -       char *x509_name, *module_name, *dest_name;
>>          unsigned char buf[4096];
>>          unsigned long module_size, sig_size;
>>          unsigned int use_signed_attrs;
>> @@ -315,32 +347,27 @@ int main(int argc, char **argv)
>>          argv += optind;
>>
>>          const char *raw_sig_name = opts.raw_sig_name;
>> +       const char *hash_algo = opts.hash_algo;
>> +       const char *private_key_name = opts.private_key_name;
>> +       const char *x509_name = opts.x509_name;
>> +       const char *module_name = opts.module_name;
>>          const bool save_sig = opts.save_sig;
>>          const bool raw_sig = opts.raw_sig;
>>          const bool sign_only = opts.sign_only;
>>          bool replace_orig = opts.replace_orig;
>> +       char *dest_name = opts.dest_name;
>>   #ifndef USE_PKCS7
>>          const unsigned int use_keyid = opts.use_keyid;
>>   #endif
>>
>> -       if (argc < 4 || argc > 5)
>> +       if (!argv[0] || argc != 1)
>>                  format();
> 
> 
> 
> You are breaking the bisect'ability.
> 
> You are turning the positional parameters into options
> but not adjusting scripts/Makefile.modinst in the same commit.
> 
> 
> 
> 
> 
> masahiro@oscar:~/ref/linux((HEAD detached at 41cb7c94595d))$ make
> INSTALL_MOD_PATH=/tmp/modules  modules_install
>    INSTALL /tmp/modules/lib/modules/6.5.0-rc4+/kernel/arch/x86/events/amd/power.ko
>    SIGN    /tmp/modules/lib/modules/6.5.0-rc4+/kernel/arch/x86/events/amd/power.ko
> Usage: scripts/sign-file [OPTIONS]... [MODULE]...
> Available options:
> -h, --help             Print this help message and exit
> 
> Optional args:
> -s, --rawsig <sig>     Raw signature
> -p, --savesig          Save signature
> -d, --signonly         Sign only
> -k, --usekeyid         Use key ID
> -b, --bulksign         Sign modules in bulk
> -r, --replaceorig      Replace original
> -t, --dest <dest>      Destination path (Exclusive with bulk option)
> 
> Mandatory args:
> -i, --privkey <key>    Private key
> -a, --hashalgo <alg>   Hash algorithm
> -x, --x509 <x509>      X509
> 
> Examples:
> 
>      Regular signing:
>       scripts/sign-file -a sha512 -i certs/signing_key.pem -x
> certs/signing_key.x509 <module>
> 
>      Signing with destination path:
>       scripts/sign-file -a sha512 -i certs/signing_key.pem -x
> certs/signing_key.x509 <module> -t <path>
> 
>      Signing modules in bulk:
>       scripts/sign-file -a sha512 -i certs/signing_key.pem -x
> certs/signing_key.x509 -b <module1> <module2> ...
> make[2]: *** [scripts/Makefile.modinst:87:
> /tmp/modules/lib/modules/6.5.0-rc4+/kernel/arch/x86/events/amd/power.ko]
> Error 2
> make[2]: *** Deleting file
> '/tmp/modules/lib/modules/6.5.0-rc4+/kernel/arch/x86/events/amd/power.ko'
> make[1]: *** [/home/masahiro/ref/linux/Makefile:1964: modules_install] Error 2
> make: *** [Makefile:234: __sub-make] Error 2
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> --
> Best Regards
> Masahiro Yamada

Hi Masahiro Yamada,

Thanks for the review. I will fix this. It's hard to keep the commits 
small and not breaking the bisect during code refactoring. In this case 
it's not a problem. Thanks for this input.

-- 
Shedi

