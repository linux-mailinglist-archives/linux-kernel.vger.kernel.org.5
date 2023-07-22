Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBC775D80A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 02:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjGVAJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 20:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjGVAJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 20:09:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD0C30FF;
        Fri, 21 Jul 2023 17:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1689984553; x=1690589353; i=w_armin@gmx.de;
 bh=K7v4oJ8bdkwFUPWX9U+8bpz7Y/cvFtbhuun3p54pee0=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=qwKRhfghIa3keHMzx4uSFavLV4CO/ROdE/39zcMNui9uRJvQl5FnR+xG+bQ0ANHoxZjdo1d
 vpgX9ySRQ6X7Xj8OQlIEqD+xT/cOMbu5OvZu2tUIk+roni2wAVMM3jfc96zn42qvAEMRYkn+x
 pE6ubj5wG7ijk+L5D97T4I0WFKc0a64omALaFom58Hi4HpccwvVRpQvnv7VucTOtvfBGlRLYK
 pTya5W20i23696QtA2woG9xsc2YP3K11/+yKGEiCGJQ8tUaPMDLaALqHGTk13/sN7gVMzzhS3
 fRi6qu4fHAXt0V7mHYNZRTglQXx49XkAY5swSojd+bE4AnWWJFrA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSKuA-1qThDt1SbA-00Sdzc; Sat, 22
 Jul 2023 02:09:13 +0200
To:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Armin Wolf <W_Armin@gmx.de>
Subject: WMI probe failure when reprobing
Message-ID: <1252c8fb-8d5f-98ad-b24a-5fabec2e1c8b@gmx.de>
Date:   Sat, 22 Jul 2023 02:09:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:ieJ3CecbsjmP11vfKIEAPflCd7vibaLKj4sekxzv5yerJQjjw2l
 E80/JeqZPifOz4f5gvvepLlGpQMVXNAoD2TdhRXnh5cqmpw9cljCh9LmzSJ6JA+3n3tHdo4
 Z1oBA/+bptEgHJCu+Z9bRKjKcvsqA82iz1M8RBmeXKbwjbVCQWvdu//vodR22h2G/7uotmk
 sqMV1tgliyacBV9AGc2qA==
UI-OutboundReport: notjunk:1;M01:P0:5atBhy26hpM=;h62WOA6O+MGfKxeXV1o+KhFnYrd
 qcWGHqmtYZZ293JgLXaAI1hdhnX1RoWlbc2uDuCP7AOALvBDI70GBK1ZiSil6LPEJIO4zigH3
 jUgzMKukwcj/Wb33Un7cK3l+kyFhnK3452c0DTr+a1Wjy+DpveFWad7u4UNr88xKlKpgDzVyU
 7whK2sELy/rUC9f1nvYUKWJyx5BWxjs4BpyVuAAeBFHHkN1NY1n2ym+eEwfG4VJcLqxOLzLPB
 iYJDObt8B+nX0dfVTvP/cpLOOPsYmtjN8+wjcy3XNMpuZTkTlDHWpQ462ZXyZQFl2v21Eak3r
 ws1lNxRU51EAU3oZU2/qGaYizTX+aggcNgQQ8vBXRuIDpXi7qCGJpGZmL3Zzhz359nNAhjnJX
 GMH1Ot4yWXgfCgw1KMFIJi56AHloqQ5J9ezfNFFFZKwcMSZ8GQBvAroc0EGOeJKLBjQPXgzr9
 rdyVvN4ZioAtuo5MO+BlZiQLQaIY3XAIuDbP8HjxSYX5E05sL7MoelaFr7OopkFdG6xmUL9IK
 xL+7UOq9ufhzmIKOBhbROOK9qiWxyo0tlHoeBfONSl7gqyI4LrwYx4YSDKBYpl4IDcLaAMrOM
 8LahbpVfMoZpqybPCNQeaWOZux9Z+IRQXoA5rJT/sh4DO4oNM2CYGLzKMtMYhkZc3/jVdMwak
 FcsamAI9zH4fFSDXGylb22GdGyhrWX6QbbyugjBUZrHNOljgz4m1dABiYYzpKNBAWe36ph25l
 Kjfq+tMNUM8OH3J8Yb5IxJv/YsctGMJ2TqVEYRIJtmwTwm2m8RJtyF8br1xHZPdXHmSe+XVab
 OHYaZSGr/Qea4UjG7IxV/KWBIUgbO5iVyAUaYSb88PqeBu4OkaOhCNzgRDkQDCIeWqx2yX2Qo
 iS7eGxmkelcnYdLUDVlLAfNsYqF3uvW9XaMMtSyFASSuklsvJrJ5JKBz+D5vos6rFfGBuNVAz
 4W++SFgM4SXnSpk2gOIg726BE8M=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i just noticed that under some circumstances, ACPI WMI devices might fail to reprobe
when being manually unbound and later rebound.
Example:

1. ACPI WMI device #1 binds and registers WMI device with GUID
"05901221-D566-11D1-B2F0-00A0C9062910", resulting in the device
being named "05901221-D566-11D1-B2F0-00A0C9062910".
2. ACPI WMI device #2 binds and registers WMI device with GUID
"05901221-D566-11D1-B2F0-00A0C9062910", resulting in the device
being named "05901221-D566-11D1-B2F0-00A0C9062910-1".
3. ACPI WMI device #1 is manually unbound and later rebound,
now the WMI device with GUID "05901221-D566-11D1-B2F0-00A0C9062910"
is being named "05901221-D566-11D1-B2F0-00A0C9062910-1" too, since
device naming depends on the number of GUIDs currently known to
the WMI subsystem.
4. A WMI device named "05901221-D566-11D1-B2F0-00A0C9062910-1" already
exists, causing the registration of the new WMI device to fail.

I thought about some possible ways to solve this naming issue:

- symlinks to simulate old WMI devices names, new WMI device names similar to "wmiX" with X being a global unique id
- no symlinks, new WMI device names similar to "wmiX" with X being a global unique id
- use global id instead of GUID number

The first approach has full sysfs backward compatibility but i do not know how to create symlinks inside the "devices"
directory. The second approach is the easiest and cleanest one, but provides no sysfs backward compatibility. The last
approach provides only limited sysfs backward compatibility and only for programs which can handle "<GUID>-X" WMI device
names.

Currently, there is one single stable sysfs ABI entry concerning the WMI subsystem (for wmi-bmof), and two testing
sysfs ABI entries (dell-wmi-privacy, sbl-fw-update). I do not know of any userspace programs relying on these ABIs,
but i suspect there might be a couple of scripts which might be affected.

Which approach should i take to solve this problem?

Armin Wolf

