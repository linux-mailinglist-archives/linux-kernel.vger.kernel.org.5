Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9A97DB860
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbjJ3Kh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbjJ3KhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:37:03 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F404C9D
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:36:58 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-8f-653f8749bddc
Date:   Mon, 30 Oct 2023 19:36:52 +0900
From:   Byungchul Park <byungchul@sk.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "kernel_team@skhynix.com" <kernel_team@skhynix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "xhao@linux.alibaba.com" <xhao@linux.alibaba.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "hughd@google.com" <hughd@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "david@redhat.com" <david@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [v3 3/3] mm, migrc: Add a sysctl knob to enable/disable MIGRC
 mechanism
Message-ID: <20231030103652.GC81877@system.software.com>
References: <20231030072540.38631-1-byungchul@sk.com>
 <20231030072540.38631-4-byungchul@sk.com>
 <17CADC36-25C6-44EB-8084-6E3D9D64B3D3@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17CADC36-25C6-44EB-8084-6E3D9D64B3D3@vmware.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsXC9ZZnoa5Xu32qwf6dvBZz1q9hs/i84R+b
        xYsN7YwWX9f/YrZ4+qmPxeLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHF910NGi+O9B5gs
        Nm+aymzx+wdQ3ZwpVhYnZ01mcRDw+N7ax+KxYFOpx+YVWh6L97xk8ti0qpPNY9OnSewe786d
        Y/c4MeM3i8fOh5Ye804Gerzfd5XNY+svO4/Pm+Q83s1/yxbAF8Vlk5Kak1mWWqRvl8CV8f7T
        dfaCxawV/1qnsjQw9rN0MXJySAiYSJx50ccOYz9Z3wgWZxFQlXhx6yoriM0moC5x48ZPZhBb
        REBR4tD+e4wgNrPAO1aJ7580uxg5OIQFwiQeLQkGCfMKWEjM/30XrFVIYCqjxOfD+hBxQYmT
        M5+wQLSqS/yZd4kZpJVZQFpi+T8OiLC8RPPW2WCbOAXsJA6dmgk2RlRAWeLAtuNMXYxcQFdu
        Y5eYsn8FM8TJkhIHV9xgmcAoOAvJillIVsxCWDELyYoFjCyrGIUy88pyEzNzTPQyKvMyK/SS
        83M3MQIjdlntn+gdjJ8uBB9iFOBgVOLhDQi3SxViTSwrrsw9xCjBwawkwsvsaJMqxJuSWFmV
        WpQfX1Sak1p8iFGag0VJnNfoW3mKkEB6YklqdmpqQWoRTJaJg1OqgbFoQq16/2P2azOzgnzX
        lvucS2VQmrLH0+b5On7+7V9SZa6tWHT8g9Whdp1VAj+bm/NWvY4+yL/RK2nfhDL/h8cfHmFv
        r7Vou3c399PnCPa6x+dmur1g5bw964/3ifIZT1b2xKyK3K/xY4rn4b87nVpfGf4xjE6u2fs8
        3OQe73E/q8s66QoJ3e1KLMUZiYZazEXFiQC0RpVO1AIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsXC5WfdrOvZbp9qMO21ucWc9WvYLD5v+Mdm
        8WJDO6PF1/W/mC2efupjsTg89ySrxeVdc9gs7q35z2pxftdaVosdS/cxWVw6sIDJ4vquh4wW
        x3sPMFls3jSV2eL3D6C6OVOsLE7OmsziIOjxvbWPxWPBplKPzSu0PBbvecnksWlVJ5vHpk+T
        2D3enTvH7nFixm8Wj50PLT3mnQz0eL/vKpvH4hcfmDy2/rLz+LxJzuPd/LdsAfxRXDYpqTmZ
        ZalF+nYJXBnvP11nL1jMWvGvdSpLA2M/SxcjJ4eEgInEk/WNYDaLgKrEi1tXWUFsNgF1iRs3
        fjKD2CICihKH9t9jBLGZBd6xSnz/pNnFyMEhLBAm8WhJMEiYV8BCYv7vu2CtQgJTGSU+H9aH
        iAtKnJz5hAWiVV3iz7xLzCCtzALSEsv/cUCE5SWat84G28QpYCdx6NRMsDGiAsoSB7YdZ5rA
        yDcLyaRZSCbNQpg0C8mkBYwsqxhFMvPKchMzc0z1irMzKvMyK/SS83M3MQLjb1ntn4k7GL9c
        dj/EKMDBqMTDGxBulyrEmlhWXJl7iFGCg1lJhJfZ0SZViDclsbIqtSg/vqg0J7X4EKM0B4uS
        OK9XeGqCkEB6YklqdmpqQWoRTJaJg1OqgTFNoXetrVGQ97p9Fm36Z/48e/Xo7Nl7LafeTo6+
        IvCTu2iiz/PTeyuYfwu4/g3lSpxzdAmz27fu5pwdQu66vE8MlyzpjuFJ8HT/9SnbvTjea53N
        Jdmlz2aJ/2g6XbVEIYvb9Rj35pCOg/se9Me1Xno9I1DpkVnl8/VzzZSauXjKoj+u9Lv0tE6J
        pTgj0VCLuag4EQAc7b8/uwIAAA==
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 08:51:35AM +0000, Nadav Amit wrote:
> 
> > On Oct 30, 2023, at 9:25 AM, Byungchul Park <byungchul@sk.com> wrote:
> > 
> > Add a sysctl knob, '/proc/sys/vm/migrc_enable' to switch on/off migrc.
> 
> Please explain how users are expected to use this knob.
> 
> I suspect that the knob and the config option are not useful. You probably
> used them for your evaluation or as a “chicken-bit”, but they are not
> useful anymore.

Okay. We can add the sysctl knob when we need it. Will remove it for now.

However, I'm not sure if it'd be okay without CONFIG_MIGRC. I'd like to
see more opinion on it before going with it.

	Byungchul
